window.app.service "User", ($firebase, $firebaseAuth, firebaseURL) ->
	@all = () ->
		ref = new Firebase("#{firebaseURL}/users")
		users = $firebase(ref).$asArray()
		return users.$loaded()
	
	@find = (id) ->
		url = "#{firebaseURL}/users/#{id}"
		ref = new Firebase(url)
		user = $firebase(ref).$asObject()
		user.$loaded()
	return
