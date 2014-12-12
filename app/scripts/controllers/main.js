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
   })
    if($rootScope.current_user.roles == 'Admin'){
      $location.path('/admin/dashboard');
      $scope.$apply();
    }else{
      $location.path('/dashboard');
      $scope.$apply();
    } 
  }).catch(function(error) {
    console.error('Authentication Failed:', error);
  });

};
});


 angular.module('sraAngularApp')
  .controller('DashboardController', function ($scope, $location, $firebase, $rootScope){
 $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
 if($rootScope.current_user.roles == 'Admin'){
  $location.path('/admin/dashboard')
  $scope.$apply();
 };
})


angular.module('sraAngularApp')
.controller('AreasController', function ($scope, $location, $firebase, $routeParams,$rootScope){
  var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Users/User%201/Organizations/Organization/Region/Region0/Areas');
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  $scope.areas = $firebase(ref).$asArray();
  console.log($scope.areas);
});

angular.module('sraAngularApp')
.controller('AreasIndexController', function($scope,$location,$firebase,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  console.log($rootScope.current_user.areas)
  $scope.areas = $rootScope.current_user.areas;
});

angular.module('sraAngularApp')
.controller('AreasShowController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  var name = $routeParams.name
  console.log(name)
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/South%20Africa/Areas/" + name);
  $scope.area = $firebase(ref).$asObject();

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
angular.module('sraAngularApp')
.controller('AdminDashboardController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  var name = $routeParams.name;
  var area = []

});
angular.module('sraAngularApp')
.controller('AdminUsersController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  var name = $routeParams.name;
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/South%20Africa/Areas/" + name);
  var areas = $firebase(ref);
});
angular.module('sraAngularApp')
.controller('AdminAreasController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions");
  var regionsArr = $firebase(ref).$asArray();
  $scope.regions = [];
  var areasArr = [];
  regionsArr.$loaded().then(function(data){
    for(var region in regionsArr){
      if(regionsArr[region].$id != undefined){
        $scope.regions.push(regionsArr[region].$id)
        console.log($scope.regions[region])
        for(var name in $scope.regions){
            var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/"+$scope.regions[region]+"/Areas")
            var sync = $firebase(ref).$asObject();
            sync.$loaded().then(function(areaData){
              areasArr.push(areaData)
              $scope.areas = [];
              $scope.areas = $scope.areas.concat.apply($scope.areas, areasArr);
              console.log($scope.areas)
             
            })
      }

    } 
    }

});

  
      
});




