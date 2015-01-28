window.app.service "User", ($firebase, $firebaseAuth, firebaseURL) ->
	@all = ($scope) ->
		$scope.users = []
		User = this
		ref = new Firebase("#{firebaseURL}organizations/sra/users")
		users = $firebase(ref).$asArray()
		users.$loaded().then (data) ->
			for user in data
				User.find(user.$id).then (userObj) ->
					if(userObj.email != undefined)
						$scope.users.push userObj
	
	@find = (id) ->
		url = "#{firebaseURL}users/#{id}"
		ref = new Firebase(url)
		user = $firebase(ref).$asObject()
		user.$loaded()
	return
