'use strict';

/*Constants*/
app.constant('firebaseURL', 'https://intense-inferno-7741.firebaseio.com/'  /*'https://torid-inferno-2841.firebaseio.com/'*/);

app.controller('LoginController', function ($scope, $firebaseAuth, $location, $firebase, $rootScope, firebaseURL, OrgBuilder) {
	$scope.Login = function () {
		var email = $scope.user.email;
		var password = $scope.user.password;
		var ref = new Firebase(firebaseURL);

		$scope.authObj = $firebaseAuth(ref);
		$scope.authObj.$authWithPassword({
			email: email,
			password: password
		}).then(function (authData) {
			console.log('Logged in as:', authData.password.email);
			var node = email.split('@');
			var userRef = new Firebase(firebaseURL + 'Users/' + node[0]);
			var userObj = $firebase(userRef).$asObject();
			userObj.$loaded().then(function (data) {
				$scope.fromService = OrgBuilder.userCache(data);
			}).then(function () {
				if ($rootScope.currentUser.roles !== undefined) {
					if ($rootScope.currentUser.roles === 'Admin') {
						$scope.fromService = OrgBuilder.orgCache(firebaseURL);
						$location.path('/admin/dashboard');
						$scope.$apply();
					} else if ($rootScope.currentUser.roles === 'Developer') {
						$location.path('/dashboard');
						$scope.$apply();
					} else {
						$location.path('/dashboard');
					}
				}
			});
		}).catch(function (error) {
			console.error('Authentication Failed:', error);
		});
	};
});

app.controller('DashboardController', function ($scope, $location, $firebase, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
	$scope.user = $rootScope.currentUser;
	$scope.areas = $rootScope.currentUser.areas;
	// var regions = $scope.user.regions; // Defined but never used
	$scope.firstname = $rootScope.currentUser.firstName;
	$scope.lastName = $rootScope.currentUser.lastName;
	console.log('here');



	if ($rootScope.currentUser.roles === 'Admin') {
		$location.path('/admin/dashboard');
		$scope.$apply();
	}
});
