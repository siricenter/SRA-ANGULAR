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
 
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/South%20Africa/Areas/" + name);
  var area = $firebase(ref).$asObject();
  area.$loaded().then(function(data){
  var names = Object.keys(data.Resources);
  
  $scope.households = [];
  
function Household(family,members){
    this.family = family;
    this.members = members;
};

var list = new Array();

for(var family in names){
  var members =  Object.keys(data.Resources[names[family]].Members);
  $scope.households[family] = new Household(names[family], members);
}
console.log($scope.households)
 
  })

});

angular.module('sraAngularApp')
.controller('AdminDashboardController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  $scope.firstname = $rootScope.current_user.first_name
  $scope.lastname = $rootScope.current_user.last_name
  console.log($rootScope.current_user)

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
  var regions = JSON.parse(localStorage['regions']);
    if(regions != undefined){
      for(var i = 0; i < regions.length; i++){
         var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/"+regions[i]+"/Areas")
          var sync = $firebase(ref).$asArray();
          var areasArr = [];
            sync.$loaded().then(function(areaData){
              areasArr.push(areaData)
              var areas = [];
              $scope.areas = areas.concat.apply(areas, areasArr);
              console.log($scope.areas.Name)         
            })
      }
    }
});


angular.module('sraAngularApp')
.controller('AdminUsersController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Users")
  $scope.users = $firebase(ref).$asArray();
  $scope.users.$loaded(function(data){
    localStorage.setItem('users', JSON.stringify($scope.users));
  })
  console.log($scope.users)
          
});
angular.module('sraAngularApp')
.controller('EditUsersController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  $scope.username = $routeParams.id
  $scope.UpdateUser = function(){
      var fname = $scope.user.fname;
      var lname = $scope.user.lname;
      console.log(JSON.parse(localStorage.getItem('users')))
      var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Users/" + $scope.username)
      var sync = $firebase(ref)
      sync.$update({ FirstName: fname, LastName: lname }).then(function(ref) {
        ref.key();   // bar
      }, function(error) {
        console.log("Error:", error);
        });;
  }        
});

angular.module('sraAngularApp')
.controller('NewUsersController', function ($scope,$location,$firebase,$routeParams,$rootScope,$firebaseAuth){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  $scope.CreateUser = function(){
    console.log('hello')
    var user_node = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Users")
    var email = $scope.user.email;
    var password = $scope.user.password;
    var fname = $scope.user.fname;
    var lname = $scope.user.lname;
    var ref = new Firebase('https://intense-inferno-7741.firebaseio.com');
    $scope.authObj = $firebaseAuth(ref);
    $scope.authObj.$createUser(email, password).then(function() {
      console.log("User created successfully!");
      user_node.push(user_node.child(email.split('@')[0]).set({"FirstName":fname ,"LastName":lname}))
      return $scope.authObj.$authWithPassword({
      email: email,
      password: email
      });
      }).catch(function(error) {
      console.error("Error: ", error);
    });
  }
});   

angular.module('sraAngularApp')
.controller('AreasUsersController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  $scope.regions = JSON.parse(localStorage.getItem('regions'));
  var region = $routeParams.name
  var areas_ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/" + region)
  var areas = $firebase(areas_ref).$asArray();
  areas.$loaded(function(){
    $scope.areas = areas[0]
    console.log($scope.areas)
  })
  console.log($scope.regions)
});
angular.module('sraAngularApp')
.controller('AreasNewController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  $scope.regions = JSON.parse(localStorage.getItem('regions'));
  var region = $routeParams.name
  $scope.region = $routeParams.name
  var ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/" + region +"/Areas")
  var areas_ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/" + region)
  var areas = $firebase(areas_ref).$asArray();
  areas.$loaded(function(){
    $scope.areas = areas[0]
    console.log($scope.areas)
  })
  $scope.CreateArea = function(){
    var name = $scope.area.name
      ref.push(ref.child(name).set({"Name": name}));
    }
  
 
});

angular.module('sraAngularApp')
  .controller('AreasEditController', function ($scope,$location,$firebase,$routeParams,$rootScope) {
    console.log('here')
    $scope.area = $routeParams.name
    $scope.UpdateArea = function(){
    var name = $scope.area.name
     $scope.area = name;
    }

  });
