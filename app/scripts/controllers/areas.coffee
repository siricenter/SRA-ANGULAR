"use strict"
window.app.controller "AreasController", ($scope, $location, $firebase, $routeParams, $rootScope, currentUser) ->
	$scope.regions = currentUser.currentUser().regions
	$scope.areas = $rootScope.currentUser.areas
	return

window.app.controller "AreasIndexController", ($scope, $location, $firebase, $rootScope, currentUser) ->
	$scope.areas = currentUser.currentUser().areas
	return

window.app.controller "AreasShowController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) ->
	name = $routeParams.name
	ref = new Firebase(firebaseURL + "organizations/sra/regions/South%20Africa/areas/" + name)
	area = $firebase(ref).$asObject()
	area.$loaded().then (area) ->
		Household = (family, members) ->
			@family = family
			@members = members
			return
		names = Object.keys(area.resources)
		$scope.households = []
		
		# var list = []; // Defined, but never used.
		for family of names
			members = Object.keys(area.resources[names[family]].members)
			$scope.households[family] = new Household(names[family], members)
		return

	return

window.app.controller "AreasNewController", ($scope, $location, $currentUser) ->
	return
