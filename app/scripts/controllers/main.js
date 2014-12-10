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

angular.module('sraAngularApp').constant('firebaseURL', 'https://intense-inferno-7741.firebaseio.com/' /*'https://torid-inferno-2841.firebaseio.com/'*/);


   angular.module('sraAngularApp')
  .controller('LoginController', function ($scope, $firebaseAuth, $location, $firebase, $rootScope){

    $scope.Login = function(){
    var email = $scope.user.email;
    var password = $scope.user.password;
    var ref = new Firebase('https://intense-inferno-7741.firebaseio.com');
    $scope.authObj = $firebaseAuth(ref);
    $scope.authObj.$authWithPassword({
    email: email,
    password: password
  }).then(function(authData) {

    console.log("Logged in as:", authData.password.email);
    var node = email.split('@');
    var user_ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Users/" + node[0])
    var userObj = $firebase(user_ref).$asObject();
    userObj.$loaded().then(function(data){ 
      console.log(userObj)
      var regions = data.Organizations.SRA.Regions;
      var areas= new Array();
      for(var region in regions){
        areas.push(Object.keys(regions[region].Areas));

      }
      var user = {
      email: data.Email,
      first_name: data['First Name'],
      last_name: data['Last Name'],
      organizations: data.Organizations.SRA.Name,
      regions: Object.keys(regions),
      areas: areas
       
    }

    var user_js = JSON.stringify(user);
    sessionStorage.setItem('user', user_js)
    var stored_user = sessionStorage.getItem('user')
    console.log($rootScope.current_user);
   })
    $location.path('/dashboard');
    $scope.$apply();
  }).catch(function(error) {
    console.error('Authentication Failed:', error);
  });

};
});


 angular.module('sraAngularApp')
  .controller('DashboardController', function ($scope, $location, $firebase, $rootScope){
  console.log($rootScope.current_user);
});

angular.module('sraAngularApp')
.controller('AreasController', function ($scope, $location, $firebase, $routeParams){
  var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Users/User%201/Organizations/Organization/Region/Region0/Areas');
  $scope.areas = $firebase(ref).$asArray();
  console.log($scope.areas);
});
angular.module('sraAngularApp')
  .controller('DashboardController', function ($scope, $location, $firebase, $rootScope,$cookieStore){
  console.log($rootScope.current_user)
});

angular.module('sraAngularApp')
.controller('AreasIndexController', function ($scope,$location,$firebase,$rootScope){
  console.log($rootScope.current_user.areas[0][0])
  $scope.areas = $rootScope.current_user.areas;
});

angular.module('sraAngularApp')
.controller('AreasShowController', function ($scope,$location,$firebase,$routeParams){
  var name = $routeParams.name
  console.log(name)
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/South%20Africa/Areas/" + name);
  //$scope.area
  $scope.area = $firebase(ref).$asObject();
  //var area = $scope.area.Resources
  $scope.area.$loaded().then(function(data){
  $scope.names = Object.keys(data.Resources)
  var list = new Array();
  for(name in $scope.names){
    list.push( Object.keys(data.Resources[$scope.names[name]].Members))
  }
  $scope.memberNames = list;
  console.log(list)
  })

});
