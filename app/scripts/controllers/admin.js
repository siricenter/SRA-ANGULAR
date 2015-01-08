'use strict';

window.app.controller('AdminAreasController', function ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL	) {
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
			var ref = new Firebase(firebaseURL + 'Organizations/SRA/Regions/' + regions[i] + '/Areas');
			var sync = $firebase(ref).$asArray();
			var areasArr = [];
			sync.$loaded().then(callMe /*Maybe?*/);
		}
	}
});

window.app.controller('AdminDashboardController', function ($scope, $location, $firebase, $routeParams, $rootScope, OrgBuilder) {
	$scope.fromService = OrgBuilder.getHouseholdsFromOrg();
	console.log($scope.fromService);
	
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$rootScope.SRA = JSON.parse(localStorage.SRA);
	$scope.firstName = $rootScope.currentUser.firstName;
	$scope.lastName = $rootScope.currentUser.lastName;
	console.log($rootScope.currentUser);
	console.log($rootScope.SRA);
});

window.app.controller('AdminUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	var ref = new Firebase(firebaseURL + 'Organizations/SRA/Users');
	$scope.users = $firebase(ref).$asArray();
	$scope.users.$loaded(function (/*data*/) {
		localStorage.setItem('users', JSON.stringify($scope.users));
	});
	console.log($scope.users);
});

window.app.controller('EditUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.username = $routeParams.id;
	$scope.UpdateUser = function () {
		var fname = $scope.user.fname;
		var lname = $scope.user.lname;
		console.log(JSON.parse(localStorage.getItem('users')));
		var ref = new Firebase(firebaseURL + 'Organizations/SRA/Users/' + $scope.username);
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

window.app.controller('AreasUsersController', function ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.regions = JSON.parse(localStorage.getItem('regions'));

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
	var areasRef = new Firebase(firebaseURL + 'Organizations/SRA/Regions/' + $scope.region);
	var areas = $firebase(areasRef).$asArray();
	areas.$loaded(function () {
		$scope.areas = areas[0];
		console.log($scope.areas);
		console.log($scope.area + '' + '' + $scope.region + '' + '' + $scope.username);
	});
	$scope.AreaAssignemnt = function () {
		var ref = new Firebase(firebaseURL + 'Users/' + $scope.username + '/Organizations/SRA/Regions');
		var sync = $firebase(ref).$asArray;
		console.log(sync);
		console.log($scope.area + $scope.region + $scope.username);
		ref.push(ref.child($scope.region).child($scope.area).set({ 'Name': $scope.area }));
		$location.path('/');
		$scope.$apply();
	}; 
	console.log($scope.regions);
});

window.app.controller('NewUsersController',  function ($scope, $location, $firebase, $routeParams, $rootScope, $firebaseAuth, firebaseURL){
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.CreateUser = function(){
		console.log('hello');
		var userNode = new Firebase(firebaseURL + 'Organizations/SRA/Users');
		var email = $scope.user.email;
		var password = $scope.user.password;
		var fname = $scope.user.fname;
		var lname = $scope.user.lname;
		var ref = new Firebase(firebaseURL);
		$scope.authObj = $firebaseAuth(ref);
		$scope.authObj.$createUser(email, password).then(function() {
			console.log('User created successfully!');
			userNode.push(userNode.child(email.split('@')[0]).set({'FirstName':fname ,'LastName':lname}));
			return $scope.authObj.$authWithPassword({
				email: email,
				password: email
			});
		}).catch(function(error) {
			console.error('Error: ', error);
		});
	};
});   

window.app.controller('AreasNewController', function ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.regions = JSON.parse(localStorage.getItem('regions'));
	var region = $routeParams.name;
	$scope.region = $routeParams.name;
	var ref = new Firebase(firebaseURL + 'Organizations/SRA/Regions/' + region + '/Areas');
	var areasRef = new Firebase(firebaseURL + 'Organizations/SRA/Regions/' + region);
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

window.app.controller('AreasEditController',  function ($scope, $location, $firebase, $routeParams, firebaseURL) {
	$scope.area = $routeParams.name;
	$scope.region = $routeParams.region;

	console.log($scope.area);
	console.log($scope.region);
	console.log(firebaseURL + 'Organizations/SRA/Regions/' + $scope.region +'/Areas/' + $scope.area);

	$scope.UpdateArea = function(){
		console.log('here');
		var ref = new Firebase(firebaseURL + 'Organizations/SRA/Regions/' + $scope.region +'/Areas/' + $scope.area);
		var name = $scope.Area.name;
		ref.set(name);
	};
});
