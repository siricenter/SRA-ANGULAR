window.app.controller "LoginController", ($scope, $location, $rootScope, currentUser) ->

	$rootScope.title = "Login"

	currentUser.currentUser().then (user) ->
			$location.path('/admin/dashboard')

	loginFunction = ->
		email = $scope.user.email
		password = $scope.user.password

		currentUser.authenticate(email, password)

	$scope.submit = loginFunction
	return

window.app.controller "DashboardController", ($scope, $location, $rootScope, currentUser) ->
	$rootScope.title = "Dashboard"

	currentUser.currentUser().then () ->
		$scope.user = user
		$scope.areas = user.areas
		$scope.firstname = user.firstName
		$scope.lastName = user.lastName

	$location.path "/admin/dashboard" if user.roles is "Admin"
	return
