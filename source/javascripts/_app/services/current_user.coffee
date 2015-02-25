window.app.service "currentUser", ($rootScope, $location, firebase, firebaseURL, orgBuilder, $q) ->
	@requireLogin = () ->
		currentUser = this
		return $q((resolve, reject) ->
			currentUser.currentUser()
				.then ( user ) ->
					$rootScope.currentUser = user
					resolve(user)
				.catch () ->
					$location.path "/login"
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
		authPromise = firebase.auth(email, password)
		.then(@authed(email))
		.catch (error) ->
			# We really should do something better on failure, like post a
			# notification on the login page.
			console.error "Authentication Failed:", error
			return # Void
		return authPromise
	
	# Retrieves the user information from the firebase instance
	@getUser = (userName) ->
		url = "#{firebaseURL}/users/#{userName}"
		firebase.queryObject( url ).then((user) ->
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
	
	@loginRedirect = ( user ) ->
		try # If one of the required keys is missing, it"ll throw an error
			$location.path "/dashboard"
			return
		catch error
			console.log "Error thrown"
			throw error


	############################################################################
	#
	# End of private functions for currentUser service
	#
	############################################################################
	return # End of service

