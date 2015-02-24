"use strict"
window.app.controller "HouseholdsIndexController", ( $scope, currentUser, Household ) ->
	currentUser.currentUser().then ( user ) ->
		Household.all( 'sra' )
			.then ( households ) ->
				$scope.households = households


