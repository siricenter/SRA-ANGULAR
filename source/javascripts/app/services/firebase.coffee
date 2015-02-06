window.app.service "firebase", ($firebase, $firebaseAuth, firebaseURL) ->
	@queryObject = ( url ) ->
		ref = new Firebase(url)
		onLoadPromise = $firebase( ref ).$asObject().$loaded()
		return onLoadPromise

	@queryArray = ( url ) ->
		ref = new Firebase(url)
		onLoadPromise = $firebase( ref ).$asArray().$loaded()
		return onLoadPromise
		
	@auth = ( email, password ) ->
		ref = new Firebase(firebaseURL)
		authObj = $firebaseAuth(ref)

		authPromise = authObj.$authWithPassword(
			email: email
			password: password
		)

		return authPromise

	return # End of service
