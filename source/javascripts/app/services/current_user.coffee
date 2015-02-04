window.app.service "currentUser", ($rootScope, $location, $firebase, $firebaseAuth, firebaseURL, orgBuilder, $q) ->
	@requireLogin = () ->
		currentUser = this
		return $q((resolve, reject) ->
			currentUser.currentUser().then((user) ->
				$rootScope.currentUser = user
				resolve(user)
			).catch(() ->
				$location.path("/login")
			)
		)

	@currentUser = () ->
			stored = sessionStorage.getItem("userId")

			if $rootScope.currentUser?
				return $q((resolve, reject) ->
					resolve($rootScope.currentUser)
				) # Return the new promise
			else if stored?
				@getUser(stored) # return the promise from @getUser
			else
				return $q((resolve, reject) ->
					reject(Error("No current user"))
				) # Return the new promise
	
	@authenticate = (email, password) ->
		authed = @authed(email)
		ref = new Firebase(firebaseURL)
		authObj = $firebaseAuth(ref)
		authObj.$authWithPassword(
			email: email
			password: password
		).then(authed)
		.catch (error) ->
			console.error "Authentication Failed:", error
			return # Void
		# Returns promise
	
	@getUser = (userName) ->
		url = "#{firebaseURL}users/#{userName}"
		ref = new Firebase(url)
		userObj = $firebase(ref).$asObject()
		userObj.$loaded().then((user) ->
			$rootScope.currentUser = user
		)



	############################################################################
	#
	# From here under is for private use only. Don"t call these functions
	# externally.
	#
	############################################################################



	@authed = (email) ->
		currentUser = this
		getUser = @getUser
		loginRedirect = @loginRedirect
		() ->
			userName = email.split("@").shift()
			getUser(userName).then (userData) ->
				orgBuilder.userCache(userData)
				currentUser.currentUser()
					.then(loginRedirect)
	
	@loginRedirect = (user) ->
		try # If one of the required keys is missing, it"ll throw an error
			if user.organizations.sra.roles.name is "admin"
				$location.path "/admin/dashboard"
			else
				$location.path "/dashboard"
			return
		catch error
			console.log "Error thrown"
			throw error

	return # End of service

