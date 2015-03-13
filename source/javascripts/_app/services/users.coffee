window.app.service "User", (firebase, firebaseURL, Organization) ->
	@all = () ->
		url = "#{ firebaseURL }/users"
		onLoadPromise = firebase.queryArray( url )
		return onLoadPromise

	@find = ( id ) ->
		url = "#{firebaseURL}/users/#{id}"
		onLoadPromise = firebase.queryObject( url )
		return onLoadPromise

	@findByEmail = ( email ) ->
		url = "#{firebaseURL}/users"
		firebase.searchByChild( url, 'email', email )

	@addOrg = ( user, orgID ) ->
		Organization.find( orgID ).then ( org ) ->
			Organization.addUser( org, user )

	@create = ( userData ) ->
		#userName = email.split("@").shift()
		User = this
		firebase.createUser(userData)
			.then (userRef) ->
				User.find( userRef.key() )
			.then ( user ) ->
				# 'sra' can easily be switched to currentOrg when we have that
				User.addOrg( user, 'sra' )
	
	@cache = ( user ) ->
		sessionStorage.userId = user.$id
	
	@uncache = ( user ) ->
		sessionSotrage.removeItem( 'userId' )
	return
