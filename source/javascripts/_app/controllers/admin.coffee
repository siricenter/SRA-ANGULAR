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

window.app.controller "EditUsersController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL, currentUser) ->
	currentUser.requireLogin()
	$scope.name = $routeParams.id
	$scope.userRoles = []
	userRef = new Firebase("#{firebaseURL}/users/#{$scope.name}/organizations/sra/roles")
	userSync = $firebase(userRef).$asArray()
	userSync.$loaded().then (roles)->
		for role in roles
			$scope.userRoles.push(role.$value)

			return

	rolesref = new Firebase("#{firebaseURL}/organizations/sra/roles")
	rolessync = $firebase(rolesref).$asArray()
	rolessync.$loaded().then (data)->
		$scope.roles = data
		return


	$scope.updateUser = ->
		console.log("hi")
		fname = $scope.user.fname
		lname = $scope.user.lname
		ref = new Firebase("#{firebaseURL}organizations/sra/users/#{$scope.name}")
		sync = $firebase(ref)
		sync.$update({firstname: fname, lastname: lname}).then ->
			xref = new Firebase("#{firebaseURL}/users/#{$scope.name}")
			xsync = $firebase(xref)
			xsync.$update({firstName: fname, lastName: lname}).then ->
				$location.path('/admin/users')
				return
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

window.app.controller "NewUsersController", ($scope, $rootScope, User, currentUser) ->
	$rootScope.title = "Create User"
	currentUser.requireLogin()

	createUser = () ->
		User.create($scope.user).then(() ->
			$scope.user = {})

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

window.app.controller "AdminSecurityController", ($scope, $rootScope, $location, $firebase, $routeParams, firebaseURL, orgBuilder, currentUser) ->
	rolesref = new Firebase("https://testrbdc.firebaseio.com/organizations/sra/roles")
	rolessync = $firebase(rolesref).$asArray()
	rolessync.$loaded().then (data)->
		$scope.roles = data
		return
	console.log($routeParams.title)
	$scope.roleName = $routeParams.title
	$scope.role = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/roles/#{$scope.roleName}/permissions")).$asArray()
	$scope.role_permissions = []
	$scope.currentPermissions = []
	$scope.role.$loaded().then (data)->
		console.log(data)
		for i in data
			$scope.currentPermissions.push(i.$value)
			$scope.role_permissions.push(i.$value)

	permishref = new Firebase("https://testrbdc.firebaseio.com/permissions")
	permishSync = $firebase(permishref).$asArray()
	permishSync.$loaded().then (x) ->
		$scope.permissions = x
	$scope.rolePermissions = []
	$scope.newRoles = []
		

	$scope.editRole = ->
		console.log($scope.role_permissions)
		obj = new Firebase("https://testrbdc.firebaseio.com/organizations/sra/roles/#{$scope.roleName}")
		role_permissions = $scope.role_permissions.filter (val) -> 
  			$scope.currentPermissions.indexOf(val) == -1
  		for i in role_permissions
  			obj.child('permissions').child('permission'+ i).set(i)

  	






	$scope.addRole = (title) ->
		console.log title
		$location.path("/roles/new/permissions/#{title}")
		return
	$scope.createRole =  ->
		console.log($scope.rolePermissions)

		ref = new Firebase("https://testrbdc.firebaseio.com/organizations/sra/roles")
		ref.child($scope.roleName).child("name").set($scope.roleName)
		for permission in $scope.rolePermissions
			console.log("hi")
			role = new Firebase("https://testrbdc.firebaseio.com/organizations/sra/roles/#{$scope.roleName}")
			role.child("permissions").child("#{permission.$id}").set(permission["permission code"])
			$location.path("/admin/roles/security")

		return

window.app.controller "QuestionsAdminController", ($scope, $rootScope, $location, $firebase, $routeParams, firebaseURL, orgBuilder, currentUser) ->
 	
 	$scope.types = ["Areas","Households"]
 	$scope.questionTypes = ["Single Use","Multi-Use"]
 	
 	$scope.question = []
 	$scope.questions = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/question sets")).$asArray()
 	$scope.responseTypes = ["Date","Text","Number","Multi-Choice","Single-Choice"]
 	$scope.points = []

	   
 	$scope.buildSurvey = ->
 		
 		if $scope.survey_type == '1'
 			$scope.survey_type = "HOUSEHOLD"
 		else if $scope.survey_type == '0'
 			$scope.survey_type = "AREA"

 		if $scope.quest.type == '4'
 			$scope.quest.type = true
 		else if $scope.quest.type == '3'
 			$scope.quest.type = false
 		else if $scope.quest.type == undefined
 			$scope.quest.type = false

 		dataPointsArray = []

 		class DataPoint
  			constructor: (label,singleAnswer,type,answers) ->
   				@label = label
   				@singleAnswer = singleAnswer
   				@type = type
   				@answers = answers

   		for label in $scope.points
   			datapoint = new DataPoint
   			datapoint.label = label
   			for type in $scope.types
   				datapoint.type = type
   				datapoint.singleAnswer = $scope.quest.type
   				datapoint.answers = [""]
   				dataPointsArray.push(datapoint)

 		questions = {
 			name: $scope.questionTitle,
 			multiUse:$scope.quest.type,
 			dataPoints:dataPointsArray
 		}

 		questionsArray = []
 		questionsArray.push(questions)

 		questionSet = {
 			name: $scope.surveyTitle,
 			type: $scope.survey_type,
 			questions: questionsArray
 			qSetId: null

 		}


 		ref = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/question%20sets")).$asArray()
 		console.log(ref)
 		ref.$add(questionSet).then (ref) ->
 			id = ref.key()
 			console.log(id)
 			objref = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/question%20sets/#{id}"))
 			objref.$set('qSetId', id).then (data) ->
  				data.key()
  				# foo
  				return
			






 		
 			

	
	return	
 		
