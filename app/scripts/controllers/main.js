'use strict';



/**
 * @ngdoc function
 * @name sraAngularApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the sraAngularApp
 */



angular.module('sraAngularApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });

angular.module('sraAngularApp')
  .service('sharedData', function () {
      var region;
      var area;
      var resource;

      // place getters/setters here
      return {
          getRegion: function () {
              return region;
          },
          setRegion: function(value) {
              region = value;
          },
          getArea: function() {
            return area;
          },
          setArea: function(value) {
            area = value;
          },
          getResource: function() {
            return resource;
          },
          setResource: function(value) {
            resource = value;
          }
      };
  });


/*Constants*/

angular.module('sraAngularApp').constant("firebaseURL", "https://intense-inferno-7741.firebaseio.com/" /*"https://torid-inferno-2841.firebaseio.com/"*/);


  angular.module('sraAngularApp')
  .controller('LoginController', function ($scope, $firebaseAuth, $location, $firebase, $rootScope){

    $scope.Login = function(){
    var email = $scope.user.email
    var password = $scope.user.password
    var ref = new Firebase("https://intense-inferno-7741.firebaseio.com");
    $scope.authObj = $firebaseAuth(ref);
    $scope.authObj.$authWithPassword({
    email: email,
    password: password
  }).then(function(authData) {
    console.log("Logged in as:", authData.password.email);
    $rootScope.current_user = email;
    $location.path('/dashboard');
    $scope.$apply();
  }).catch(function(error) {
    console.error("Authentication Failed:", error);
  });

}
});

 angular.module('sraAngularApp')
  .controller('DashboardController', function ($scope, $location, $firebase, $rootScope){
  console.log($rootScope.current_user)
});

angular.module('sraAngularApp')
.controller('AreasController', function ($scope, $location, $firebase, $routeParams){
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Users/User%201/Organizations/Organization/Region/Region0/Areas")
  $scope.areas = $firebase(ref).$asArray();
  console.log($scope.areas)
});


angular.module('sraAngularApp').constant('firebaseURL', 'https://intense-inferno-7741.firebaseio.com/');

