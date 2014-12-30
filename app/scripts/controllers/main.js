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
      var roles = data.Organizations.SRA.Roles;
      var areasArray= new Array();
      for(var region in regions){
        areasArray.push(Object.keys(regions[region].Areas));

      }
      var areas = [];
      var areas = areas.concat.apply(areas, areasArray);

      var user = {
      email: data.Email,
      first_name: data['First Name'],
      last_name: data['Last Name'],
      organizations: data.Organizations.SRA.Name,
      regions: Object.keys(regions),
      areas: areas,
      roles: data.Organizations.SRA.Roles.Name
    }

    var user_js = JSON.stringify(user);
    sessionStorage.setItem('user', user_js)
    var stored_user = sessionStorage.getItem('user')
    console.log(stored_user);
    $rootScope.current_user = {};
    $rootScope.current_user = JSON.parse(stored_user);
    console.log($rootScope.current_user.roles);
   }).then(function(){
    if($rootScope.current_user.roles != undefined){
      if($rootScope.current_user.roles == 'Admin'){
      $location.path('/admin/dashboard');
      $scope.$apply();
    }else if($rootScope.current_user.roles == 'Developer'){
      $location.path('/dashboard');
      $scope.$apply();
    }else{
      $location.path('/dashboard')
    } 
    } 
   })  
  }).catch(function(error) {
    console.error('Authentication Failed:', error);
  });

};
});


 angular.module('sraAngularApp')
  .controller('DashboardController', function ($scope, $location, $firebase, $rootScope){
 $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
 $scope.user = $rootScope.current_user
 $scope.areas = $rootScope.current_user.areas
 var regions = $scope.user.regions
 

 

 if($rootScope.current_user.roles == 'Admin'){
  $location.path('/admin/dashboard')
  $scope.$apply();
 };
})



