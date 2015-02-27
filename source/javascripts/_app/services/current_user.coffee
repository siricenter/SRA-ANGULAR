window.app.service "currentUser", ( $rootScope, $location, firebase, firebaseURL, $q, User ) ->
	@requireLogin = () ->
		currentUser = this
		return $q(( resolve, reject ) ->
			currentUser.currentUser()
				.then ( user ) ->
					resolve( user )
				.catch () ->
					$location.path "/login"
		)

	@currentUser = () ->
		stored = sessionStorage.getItem( "userId" )
		currentUser = this

		if $rootScope.currentUser?
			return $q(( resolve, reject ) ->
				resolve( $rootScope.currentUser )
			) # Return the new promise
		else if stored?
			return $q(( resolve, reject ) ->
				promise = currentUser.getUser( stored )
					.then ( user ) ->
						$rootScope.currentUser = user
						return user
				resolve( promise )
			)
		else
			return $q(( resolve, reject ) ->
				reject( Error( "No current user" ))
			) # Return the new promise
	
	@authenticate = ( email, password ) ->
		currentUser = this
		authPromise = firebase.auth( email, password )
			.then () ->
				currentUser.authorized( email )
			.catch ( error ) ->
				# We really should do something better on failure, like post a
				# notification on the login page.
				console.error "Authentication Failed:", error
				return # Void
		return authPromise

	@getUser = ( id ) ->
		User.find( id )
	
	# Retrieves the user information from the firebase instance
	@getUserByEmail = ( email ) ->
		User.findByEmail( email )
			.then ( users ) ->
				return users[0] # There should only be one user with a given email. Also, what happens if no such user is registered?
			



	############################################################################
	#
	# From here under is for private use only. Don"t call these functions
	# externally.
	#
	############################################################################



	@authorized = ( email ) ->
		currentUser = this
		currentUser.getUserByEmail( email ).then ( user ) ->
			$rootScope.currentUser = user
			User.cache( user )

	############################################################################
	#
	# End of private functions for currentUser service
	#
	############################################################################
	return # End of service

