window.app.service "Organization", ( firebase, firebaseURL ) ->
	@all = () ->
		url = "#{firebaseURL}/organizations"
		firebase.queryArray( url )

	@find = ( id ) ->
		url = "#{firebaseURL}/organizations/#{id}"
		firebase.queryObject( url )
	
	@addUser = ( org, user ) ->
		user.organizations ||= {}
		user.organizations[ org.$id ] = org
		user.$save()

		org.users[ user.$id ] =
			firstName: user.firstName
			lastName: user.lastName
		org.$save()

	return
