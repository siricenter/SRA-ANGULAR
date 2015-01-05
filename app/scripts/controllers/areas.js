'use strict';

angular.module('sraAngularApp')
.controller('AreasController', function ($scope, $location, $firebase, $routeParams,$rootScope) {
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
  $scope.regions = $rootScope.currentUser.regions;
  $scope.areas = $rootScope.currentUser.areas;
  console.log($scope.areas);
});

angular.module('sraAngularApp').controller('AreasIndexController', function ($scope, $location, $firebase, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	console.log($rootScope.currentUser.areas);
	$scope.areas = $rootScope.currentUser.areas;
});

angular.module('sraAngularApp').controller('AreasShowController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	var name = $routeParams.name;
	var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/South%20Africa/Areas/' + name);
	var area = $firebase(ref).$asObject();
	area.$loaded().then(function (data) {
		var names = Object.keys(data.Resources);
		$scope.households = [];
		function Household(family, members) {
			this.family = family;
			this.members = members;
		}
		// var list = []; // Defined, but never used.
		for (var family in names) {
			var members = Object.keys(data.Resources[names[family]].Members);
			$scope.households[family] = new Household(names[family], members);
		}
		console.log($scope.households);
	});
});
