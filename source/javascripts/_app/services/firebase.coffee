window.app.service "firebase", ($firebase, $firebaseAuth, firebaseURL) ->
	@searchByChild = ( url, key, value ) ->
		ref = new Firebase( url ).orderByChild( key ).startAt( value ).endAt( value )
		onLoadPromise = $firebase( ref ).$asArray().$loaded()
		return onLoadPromise

	@queryObject = ( url ) ->
		ref = new Firebase( url )
		onLoadPromise = $firebase( ref ).$asObject().$loaded()
		return onLoadPromise

	@queryArray = ( url ) ->
		ref = new Firebase( url )
		onLoadPromise = $firebase( ref ).$asArray().$loaded()
		return onLoadPromise

	@createUser = ( userData ) ->
		url = firebaseURL

		credentials =
			email: 		userData.email
			password: 	userData.password

		users = new Firebase( url )
		authObj = $firebaseAuth( users )
		authObj.$createUser( credentials )
			.then(( userID ) ->
				user =
					firstName: 	userData.fname
					lastName: 	userData.lname
					email:		userData.email

				usersURL = "#{ firebaseURL }/users"
				usersCollection = new Firebase( usersURL )
				$firebase( usersCollection ).$push( user ))
			.catch(( data ) ->
				console.log "Failed: #{ data }")

		
	@auth = ( email, password ) ->
		ref = new Firebase( firebaseURL )
		authObj = $firebaseAuth( ref )

		authPromise = authObj.$authWithPassword(
			email: email
			password: password
		)

		return authPromise

	return # End of service
