"use strict"
window.app.controller "AdminAreasController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL, currentUser) ->
	currentUser.requireLogin()
	regions = JSON.parse(localStorage.regions)
	if regions isnt `undefined`

		# Don't define functions inside a loop. It's a performance killer.
		callMe = (areaData) ->
			areasArr.push areaData
			areas = []
			$scope.areas = areas.concat.apply(areas, areasArr)
			return

		i = 0

		while i < regions.length
			ref = new Firebase("#{firebaseURL}/organizations/sra/regions/#{regions[i]}/areas")
			sync = $firebase(ref).$asArray()
			areasArr = []
			sync.$loaded().then callMe #Maybe?
			i++
	return

window.app.controller "AdminDashboardController", ($scope, $rootScope, currentUser) ->
	$rootScope.title = "Dashboard"

	currentUser.requireLogin()

	return

window.app.controller "AdminUsersController", ($scope, $rootScope, currentUser, User) ->
	$rootScope.title = "Users Index"
	currentUser.requireLogin()

	User.all().then (users) ->
		$scope.users = users

	return

window.app.controller "EditUsersController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL, currentUser,Area) ->
	currentUser.requireLogin()
	$scope.id = $routeParams.email
	$scope.userRoles = []
	userRef = new Firebase("#{firebaseURL}/users")
	userSync = $firebase(userRef).$asArray()
	userSync.$loaded().then (users)->
		for user in users
			if user.email == $scope.id
				$scope.user = user
				console.log($scope.user.roles)
		return

	
	$scope.AssignArea = () ->
		ref = $firebase(new Firebase("#{ firebaseURL }/organizations/sra/areas")).$asArray().$loaded().then (areas)->
			$scope.areas = areas

	$scope.AssignRole = ()->
		rolesref = new Firebase("#{firebaseURL}/organizations/sra/roles")
		rolessync = $firebase(rolesref).$asArray()
		rolessync.$loaded().then (data)->
			$scope.roles = data
			return

	

	$scope.updateUser = ->
		ref = new Firebase("#{firebaseURL}/organizations/sra/users/#{$scope.user.$id}")
		ref.child('firstName').set($scope.user.firstName)
		ref.child('lastName').set($scope.user.lastName)
		userref = new Firebase("#{firebaseURL}/users/#{$scope.user.$id}")
		userref.child('firstName').set($scope.user.firstName)
		userref.child('lastName').set($scope.user.lastName)
		if $scope.user.roles != undefined
			userref.child("roles").set($scope.user.roles)
		if $scope.user.areas != undefined
			userref.child('areas').set($scope.user.areas)
		return

	$scope.updateRole = ->
		roles = $scope.userRoles
		for role in roles
			userRef = new Firebase("#{firebaseURL}/users/#{$scope.name}/organizations/sra/roles")
			userSync = $firebase(userRef)
			userSync.$update({name:role})
			return
	$scope.createPermission = ->
		permissions = $scope.permissions

	return

window.app.controller "DeleteUsersController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) ->
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"))
	$scope.name = $routeParams.name
	$scope.deleteUser = ->
		console.log($scope.name)
		ref = new Firebase("#{firebaseURL}/organizations/sra/users/")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			for i in [0...data.length] by 1
				console.log(data[i].$id)
				if data[i].$id == $scope.name
					item = data[i]
					sync.$remove(item).then (ref) ->
						$location.path("/admin/users")
						return
		return

	return

window.app.controller "AreasUsersController", ($scope) ->
	return

window.app.controller "NewUsersController", ($scope, $rootScope, $location,User, currentUser) ->
	$rootScope.title = "Create User"
	currentUser.requireLogin()
	$scope.user = {}

	createUser = () ->
		User.create($scope.user).then(() ->
			$location.path("/users/edit/#{$scope.user.email}"))


		return

	$scope.createUser = createUser

	return

window.app.controller "AreasEditController", ($scope, $location, $firebase, $routeParams, firebaseURL) ->
	$scope.area = $routeParams.name
	$scope.region = $routeParams.region
	$scope.UpdateArea = ->
		ref = new Firebase("#{firebaseURL}/organizations/sra/regions/#{$scope.region}/areas/#{$scope.area}")
		name = $scope.area.name
		ref.set name
		return

	return

window.app.controller "AdminHouseholdsController", ($scope, $rootScope, currentUser, orgBuilder) ->
	$rootScope.title = "Households Index"
	currentUser.requireLogin().then () ->
		orgBuilder.getHouseholdsFromOrg('sra').then (households) ->
			$scope.households = households
	return



 		
