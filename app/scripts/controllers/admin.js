'use strict';
angular.module('sraAngularApp').controller('AdminUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	var name = $routeParams.name;
	var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/South%20Africa/Areas/' + name);
	var areas = $firebase(ref);
});
angular.module('sraAngularApp').controller('AdminAreasController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	var regions = JSON.parse(localStorage.regions);
	if (regions !== undefined) {
		// Don't define functions inside a loop. It's a performance killer.
		var callMe = function (areaData) {
			areasArr.push(areaData);
			var areas = [];
			$scope.areas = areas.concat.apply(areas, areasArr);
			console.log($scope.areas.Name);
		};

		for (var i = 0; i < regions.length; i++) {
			var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/' + regions[i] + '/Areas');
			var sync = $firebase(ref).$asArray();
			var areasArr = [];
			sync.$loaded().then(callMe /*Maybe?*/);
		}
	}
});
angular.module('sraAngularApp').controller('AdminDashboardController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.firstname = $rootScope.currentUser.firstName;
	$scope.lastname = $rootScope.currentUser.lastName;
	console.log($rootScope.currentUser);
});
angular.module('sraAngularApp').controller('AdminUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Users');
	$scope.users = $firebase(ref).$asArray();
	$scope.users.$loaded(function (data) {
		localStorage.setItem('users', JSON.stringify($scope.users));
	});
	console.log($scope.users);
});
angular.module('sraAngularApp').controller('EditUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.username = $routeParams.id;
	$scope.UpdateUser = function () {
		var fname = $scope.user.fname;
		var lname = $scope.user.lname;
		console.log(JSON.parse(localStorage.getItem('users')));
		var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Users/' + $scope.username);
		var sync = $firebase(ref);
		sync.$update({
			FirstName: fname,
			LastName: lname
		}).then(function (ref) {
			ref.key();  // bar
		}, function (error) {
			console.log('Error:', error);
		});
	};
});
angular.module('sraAngularApp').controller('NewUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope, $firebaseAuth) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.CreateUser = function () {
		console.log('hello');
		var userNode = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Users');
		var email = $scope.user.email;
		var password = $scope.user.password;
		var fname = $scope.user.fname;
		var lname = $scope.user.lname;
		var ref = new Firebase('https://intense-inferno-7741.firebaseio.com');
		$scope.authObj = $firebaseAuth(ref);
		$scope.authObj.$createUser(email, password).then(function () {
			console.log('User created successfully!');
			userNode.push(userNode.child(email.split('@')[0]).set({
				'FirstName': fname,
				'LastName': lname
			}));
			return $scope.authObj.$authWithPassword({
				email: email,
				password: email
			});
		}).catch(function (error) {
			console.error('Error: ', error);
		});
	};
});
angular.module('sraAngularApp').controller('AreasUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.regions = JSON.parse(localStorage.getItem('regions'));
	/* What about these lines? I'm commenting them out until there's a reason
	 * for them to exist. If they are not necessary, please delete them.
	 *
	 * $scope.region;
	 * $scope.username;
	 * $scope.area;
	 */
	if ($routeParams.name !== undefined) {
		localStorage.regionParam = $routeParams.name;
	}
	if ($routeParams.id !== undefined) {
		localStorage.usernameParam = $routeParams.id;
	}
	if ($routeParams.area !== undefined) {
		localStorage.areaParam = $routeParams.area;
	}
	$scope.region = localStorage.regionParam;
	$scope.username = localStorage.usernameParam;
	$scope.area = localStorage.areaParam;
	var areasRef = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/' + $scope.region);
	var areas = $firebase(areasRef).$asArray();
	areas.$loaded(function () {
		$scope.areas = areas[0];
		console.log($scope.areas);
		console.log($scope.area + '' + '' + $scope.region + '' + '' + $scope.username);
	});
	$scope.AreaAssignemnt = function () {
		var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Users/' + $scope.username + '/Organizations/SRA/Regions');
		var sync = $firebase(ref).$asArray;
		console.log(sync);
		console.log($scope.area + $scope.region + $scope.username);
		ref.push(ref.child($scope.region).child($scope.area).set({ 'Name': $scope.area }));
		$location.path('/');
		$scope.$apply();
	}; 
	console.log($scope.regions);
});
angular.module('sraAngularApp').controller('AreasNewController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.regions = JSON.parse(localStorage.getItem('regions'));
	var region = $routeParams.name;
	$scope.region = $routeParams.name;
	var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/' + region + '/Areas');
	var areasRef = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/' + region);
	var areas = $firebase(areasRef).$asArray();
	areas.$loaded(function () {
		$scope.areas = areas[0];
		console.log($scope.areas);
	});
	$scope.CreateArea = function () {
		var name = $scope.area.name;
		ref.push(ref.child(name).set({ 'Name': name }));
	};
});
angular.module('sraAngularApp').controller('AreasEditController', function ($scope, $location, $firebase, $routeParams, $rootScope) {
	console.log('here');
	$scope.area = $routeParams.name;
	$scope.UpdateArea = function () {
		var name = $scope.area.name;
		$scope.area = name;
	};
});
