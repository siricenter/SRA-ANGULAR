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

