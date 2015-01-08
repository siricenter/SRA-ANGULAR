'use strict';


window.app.controller('HouseholdsController',  function ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	var regions = $scope.currentUser.regions;
	var area = $routeParams.area;
	$scope.households = [];

	
	var loaded = function(data) {
		if(data.Resources !== undefined) {
			$scope.households.push(data);
			for (var family in $scope.households) {
				$scope.households.families = Object.keys($scope.households[family].Resources);
				var familia = [];
				familia = $scope.households.families;
				$scope.households.familes.members = Object.keys($scope.households[family].Resources.familia[family].Members);
			}
		}
	};

	for(var i = 0; i < regions.length; i++) {
		var ref = new Firebase(firebaseURL + 'Organizations/SRA/Regions/' + regions[i] + '/Areas/'+ area);
		var sync = $firebase(ref).$asObject();

		sync.$loaded().then(loaded);

		console.log($scope.households);
	}

	$scope.ViewMembers = function() {};
});
