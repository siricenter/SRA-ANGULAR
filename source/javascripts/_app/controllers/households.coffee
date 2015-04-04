"use strict"
window.app.controller "HouseholdsIndexController", ( $scope, currentUser, Household ) ->
	currentUser.currentUser().then ( user ) ->
		Household.all( 'sra' )
			.then ( households ) ->
				$scope.households = households

window.app.controller "ShowHouseholdController", ( $scope, currentUser, $routeParams, Household ) ->
	currentUser.currentUser().then ( user ) ->
		Household.find( 'sra', $routeParams.householdId )
	.then ( household ) ->
		$scope.household = household

window.app.controller "NewHouseholdController", ( $scope, currentUser, $location, Household, Area, Country ) ->
	$scope.household = {}
	currentUser.requireLogin()
		.then () ->
			Area.all( "sra" )
		.then ( areas ) ->
			$scope.areas = areas
			$scope.household.area = areas[0].$id
		.then ( areas ) ->
			householdSubmitFunction = () ->
				Area.find( "sra", $scope.household.area )
					.then ( area ) ->
						householdData =
							country: area.country
							region: area.region
							area: area.$id			
							name: $scope.household.name
							householdID: $scope.household.name.substring(0, 3).toUpperCase() + Date.now()
						Household.create( "sra", householdData )
					.then ( householdRef ) ->
						$location.path("/households/#{ householdRef.key() }")
			$scope.submit = householdSubmitFunction
