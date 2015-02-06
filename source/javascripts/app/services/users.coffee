window.app.service "User", ($firebase, $firebaseAuth, firebaseURL, Organization) ->
	@all = () ->
		ref = new Firebase("#{firebaseURL}/users")
		users = $firebase(ref).$asArray()
		return users.$loaded()

	@find = ( id ) ->
		url = "#{firebaseURL}/users/#{id}"
		ref = new Firebase(url)
		user = $firebase(ref).$asObject()
		user.$loaded()

	@addOrg = ( user, orgID ) ->
		Organization.find( orgID ).then ( org ) ->
			Organization.addUser( org, user )

	@create = ( userData ) ->
		firebase.createUser($scope.user)
			.then (userRef) ->
				this.find( userRef.key() )
			.then ( user ) ->
				# 'sra' can easily be switched to currentOrg when we have that
				this.addOrg( user, 'sra' )
	return
