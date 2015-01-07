'use strict';

/*Constants*/
window.app.constant('firebaseURL', 'https://intense-inferno-7741.firebaseio.com/'  /*'https://torid-inferno-2841.firebaseio.com/'*/);

window.app.controller('LoginController', function ($scope, $firebaseAuth, $location, $firebase, $rootScope, firebaseURL, OrgBuilder) {
	$scope.Login = function () {
		var email, password, ref;
		
		email = $scope.user.email;
		password = $scope.user.password;
		ref = new Firebase(firebaseURL);
		$scope.authObj = $firebaseAuth(ref);
		$scope.authObj.$authWithPassword({
			email: email,
			password: password
		}).then(function () {
			var node, userRef, userObj;

			node = email.split('@');
			userRef = new Firebase(firebaseURL + 'Users/' + node[0]);
			userObj = $firebase(userRef).$asObject();

			userObj.$loaded().then(function (data) {
				$scope.fromService = OrgBuilder.userCache(data);
			}).then(function () {
				if ($rootScope.currentUser.organizations.Roles !== undefined) {
					if ($rootScope.currentUser.organizations.Roles.Name === 'Admin') {
						$scope.fromService = OrgBuilder.orgCache(firebaseURL);
						$location.path('/admin/dashboard');
						$scope.$apply();
					} else if ($rootScope.currentUser.organizations.Roles.Name === 'Developer') {
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

window.app.controller('DashboardController', function ($scope, $location, $firebase, $rootScope) {
	$rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));

	$scope.user = $rootScope.currentUser;
	$scope.areas = $rootScope.currentUser.areas;
	$scope.firstname = $rootScope.currentUser.firstName;
	$scope.lastName = $rootScope.currentUser.lastName;

	if ($rootScope.currentUser.roles === 'Admin') {
		$location.path('/admin/dashboard');
		$scope.$apply();
	}
});
