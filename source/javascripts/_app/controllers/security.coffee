window.app.controller "AdminSecurityController", ($scope, $location, $firebase, $routeParams, firebaseURL, currentUser,Role,Permission) ->
	currentUser.requireLogin().then () ->
		$scope.role_permissions = []
		$scope.currentPermissions = []
		$scope.rolePermissions = []
		$scope.newRoles = []
		Role.all().then (data)->
			$scope.roles = data
			return
		$scope.roleName = $routeParams.title
		Role.getPermissions($scope.roleName).then (data)->
			for i in data
				$scope.currentPermissions.push(i.$value)
				$scope.role_permissions.push(i.$value)
		Permission.all().then (x) ->
			$scope.permissions = x
		$scope.editRole = ->
			console.log($scope.role_permissions)
			obj = new Firebase("#{firebaseURL}/organizations/sra/roles/#{$scope.roleName}")
			role_permissions = $scope.role_permissions.filter (val) -> 
  				$scope.currentPermissions.indexOf(val) == -1
  			for i in role_permissions
  				obj.child('permissions').child('permission'+ i).set(i)
  				$scope.message = "Your changes have been sucesssfully"
		$scope.addRole = (title) ->
			$location.path("/roles/new/permissions/#{title}")
			return
		$scope.createRole =  ->
			ref = new Firebase("#{firebaseURL}/organizations/sra/roles")
			ref.child($scope.roleName).child("name").set($scope.roleName)
			for permission in $scope.rolePermissions
				console.log("hi")
				role = new Firebase("#{firebaseURL}/organizations/sra/roles/#{$scope.roleName}")
				role.child("permissions").child("#{permission.$id}").set(permission["permission code"])
				$location.path("/security")

			return
