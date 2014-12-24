'use strict';
/**
 * @ngdoc function
 * @name sraAngularApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the sraAngularApp
 */
angular.module('sraAngularApp').controller('MainCtrl', function ($scope) {
  $scope.awesomeThings = [
    'HTML5 Boilerplate',
    'AngularJS',
    'Karma'
  ];
});
/*Constants*/
angular.module('sraAngularApp').constant('firebaseURL', 'https://intense-inferno-7741.firebaseio.com/'  /*'https://torid-inferno-2841.firebaseio.com/'*/);
angular.module('sraAngularApp').controller('LoginController', function ($scope, $firebaseAuth, $location, $firebase, $rootScope) {
  $scope.Login = function () {
    var email = $scope.user.email;
    var password = $scope.user.password;
    var ref = new Firebase('https://intense-inferno-7741.firebaseio.com');
    $scope.authObj = $firebaseAuth(ref);
    $scope.authObj.$authWithPassword({
      email: email,
      password: password
    }).then(function (authData) {
      console.log('Logged in as:', authData.password.email);
      var node = email.split('@');
      var userRef = new Firebase('https://intense-inferno-7741.firebaseio.com/Users/' + node[0]);
      var userObj = $firebase(userRef).$asObject();
      userObj.$loaded().then(function (data) {
        console.log(userObj);
        var regions = data.Organizations.SRA.Regions;
		// var roles = data.Organizations.SRA.Roles; // defined, but never used
        var areasArray = [];
        for (var region in regions) {
          areasArray.push(Object.keys(regions[region].Areas));
        }
        var areas = [];
        var areas = areas.concat.apply(areas, areasArray);
        var user = {
          email: data.Email,
          firstName: data['First Name'],
          lastName: data['Last Name'],
          organizations: data.Organizations.SRA.Name,
          regions: Object.keys(regions),
          areas: areas,
          roles: data.Organizations.SRA.Roles.Name
        };
        var userJS = JSON.stringify(user);
        sessionStorage.setItem('user', userJS);
        var storedUser = sessionStorage.getItem('user');
        console.log(storedUser);
        $rootScope.currentUser = {};
        $rootScope.currentUser = JSON.parse(storedUser);
        console.log($rootScope.currentUser.roles);
      }).then(function () {
        if ($rootScope.currentUser.roles !== undefined) {
          if ($rootScope.currentUser.roles === 'Admin') {
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
angular.module('sraAngularApp').controller('DashboardController', function ($scope, $location, $firebase, $rootScope) {
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem('user'));
  if ($rootScope.currentUser.roles === 'Admin') {
    $location.path('/admin/dashboard');
    $scope.$apply();
  }
});
