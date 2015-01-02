/**
 * Created with SRA-ANGULAR.
 * User: andrewf2
 * Date: 2014-11-20
 * Time: 05:44 PM
 * To change this template use Tools | Templates.
 */
'use strict';
var controllers = {};
controllers.StaticController = function ($scope, $firebase) {
	var ref = new Firebase('https://sweltering-heat-9359.firebaseio.com/Users');
	var sync = $firebase(ref);
	$scope.users = sync.$asArray();
	console.log($scope.users);
	$scope.people = [];
	$scope.newPerson = function () {
		$scope.people.push({
			givenName: $scope.person.givenName,
			familyName: $scope.person.familyName
		});
	};
};
controllers.LoginController = function ($scope, $firebaseAuth) {
	$scope.Login = function () {
		var email = $scope.user.email;
		var password = $scope.user.password;
		var ref = new Firebase('https://sweltering-heat-9359.firebaseio.com');
		$scope.authObj = $firebaseAuth(ref);
		$scope.authObj.$authWithPassword({
			email: email,
			password: password
		}).then(function (authData) {
			console.log('Logged in as:', authData.uid);
			$scope.$apply(function () {
				$location.path('#/dashboard');
			});
		}).catch(function (error) {
			console.error('Authentication failed:', error);
		});
	};
};
controllers.AreaController = function ($scope, $firebase) {
	var areasRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/areas');
	var areasSync = $firebase(areasRef);
	$scope.areas = areasSync.$asArray();
	$scope.getArea = function () {
		var id = $scope.areaId;
		var areaRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/areas/' + id);
		var areaSync = $firebase(areaRef);
		$scope.area = areaSync.$asObject();
	};
	$scope.createArea = function () {
		var name = $scope.area.name;
		var area = { name: name };
		areasSync.push(area).then(function (ref) {
			ref.key();  // key for the new ly created record
		}, function (error) {
			console.log('Error:', error);
		});
	};
	$scope.deleteArea = function () {
		var key = $scope.area.key;
		areasSync.$remove(key);
	};
};
controllers.RegionsController = function ($scope, $firebase) {
	var regionsRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/regions');
	var regionsSync = $firebase(regionsRef);
	$scope.regions = regionsSync.$asArray();
	$scope.getRegion = function () {
		var id = $scope.region.id;
		var regionRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/regions/' + id);
		var regionSync = $firebase(regionRef);
		$scope.region = regionSync.$asObject();
	};
	$scope.createRegion = function () {
		var name = $scope.region.name;
		var region = { name: name };
		regionsSync.push(region).then(function (ref) {
			ref.key();  // key for the new ly created record
		}, function (error) {
			console.log('Error:', error);
		});
	};
	$scope.deleteRegion = function () {
		var key = $scope.area.key;
		regionsSync.$remove(key);
	};
};
controllers.UsersController = function ($scope, $firebase) {
	var usersRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/users');
	var usersSync = $firebase(usersRef);
	$scope.regions = usersSync.$asArray();
	$scope.getUser = function () {
		var id = $scope.user.id;
		var userRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/users/' + id);
		var userSync = $firebase(userRef);
		$scope.user = userSync.$asObject();
	};
	$scope.createUser = function () {
		var givenName = $scope.user.givenName;
		var familyName = $scope.familyName;
		var user = {
			givenName: givenName,
			familyName: familyName
		};
		usersSync.push(user).then(function (ref) {
			ref.key();  // key for the new ly created record
		}, function (error) {
			console.log('Error:', error);
		});
	};
	$scope.deleteUser = function () {
		var key = $scope.user.key;
		usersSync.$remove(key);
	};
};
controllers.RolesController = function ($scope, $firebase) {
	var rolesRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/roles');
	var rolesSync = $firebase(rolesRef);
	$scope.roles = rolesSync.$asArray();
	$scope.getRole = function () {
		var id = $scope.role.id;
		var roleRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/roles/' + id);
		var roleSync = $firebase(roleRef);
		$scope.role = roleSync.$asObject();
	};
	$scope.createRole = function () {
		var name = $scope.role.name;
		var permissions = $scope.role.permissions;
		var role = {
			name: name,
			permissions: permissions
		};
		rolesSync.push(role).then(function (ref) {
			ref.key();  // key for the new ly created record
		}, function (error) {
			console.log('Error:', error);
		});
	};
	$scope.deleteRole = function () {
		var key = $scope.role.key;
		rolesSync.$remove(key);
	};
};
controllers.HouseholdController = function ($scope, $firebase) {
	var houseRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/households');
	var houseSync = $firebase(houseRef);
	$scope.households = houseSync.$asArray();
	$scope.createHousehold = function () {
		// var familyName = $scope.familyName; // Defined, but never
		// used
		// var household = { familyName: familyName }; // Defined, but never
		// used
		houseSync.push(role).then(function (ref) { // role is not defined. Bug.
			ref.key();
		}, function (error) {
			console.log('Error', error);
		});
	};
};
controllers.DashboardController = function ($scope, $firebase) {
	// var areasRef = new Firebase('https://sweltering-heat-9359.firebaseio.com/users/' + id + '/areas'); // id is not defined
	// var areasSync = $firebase(areasRef); // Used in defining the areas variable, but that variable is never used.
	// var areas = areasSync.$asArray(); // Defined, but never used
};
var sraAngularApp = angular.module('sraAngularApp', []);
sraAngularApp.controller(controllers);
