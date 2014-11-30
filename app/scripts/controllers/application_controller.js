/**
* Created with SRA-ANGULAR.
* User: andrewf2
* Date: 2014-11-20
* Time: 05:44 PM
* To change this template use Tools | Templates.
*/
var controllers = {};


controllers.StaticController = function($scope, $firebase){
	
	var ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/Users");
	var sync = $firebase(ref);

    $scope.users = sync.$asArray();

 	console.log($scope.users)
	
	$scope.people = [];

	$scope.newPerson = function(){

		$scope.people.push(
			{
				given_name: $scope.person.given_name,
				family_name: $scope.person.family_name

			}
		)
	}
}

controllers.LoginController = function($scope, $firbaseAuth){

	$scope.Login = function(){
	var email = $scope.user.email
	var password = $scope.user.password
	var ref = new Firebase("https://sweltering-heat-9359.firebaseio.com");
    $scope.authObj = $firebaseAuth(ref);
	$scope.authObj.$authWithPassword({
 	email: email,
  	password: password
}).then(function(authData) {
  console.log("Logged in as:", authData.uid);
}).catch(function(error) {
  console.error("Authentication failed:", error);
});

}
}


controllers.AreaController = function($scope, $firebase){
	var areas_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/areas");
	var areas_sync = $firebase(areas_ref);
	$scope.getAreas = function(){
		$scope.areas = areas_sync.$asArray();

	}
	$scope.getArea = function(){
		var id = $scope.area_id
		var area_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/areas/"+id)
		var area_sync = $firebase(area_ref);
		$scope.area = area_sync.$asObject();
	}
	$scope.createArea = function(){
		var name = $scope.area.name;
		var area = {name: name}
		areas_sync.push(area).then(function(ref) {
  			ref.key();   // key for the new ly created record
			}, function(error) {
  			console.log("Error:", error);
			});

	}
	$scope.deleteArea = function(){
		var key = $scope.area.key
		areas_sync.$remove(key);
	}


}

controllers.RegionsController = function($scope, $firebase){
	var regions_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/regions");
	var regions_sync = $firebase(regions_ref)

	$scope.getRegions = function(){
		$scope.regions = regions_sync.$asArray();
	}
	$scope.getRegion = function(){
		var id = $scope.region.id
		var region_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/regions/"+id)
		var region_sync = $firebase(region_ref);
		$scope.region = region_sync.$asObject();
	}
	$scope.createRegion = function(){
		var name = $scope.region.name;
		var region = {name: name}
		regions_sync.push(region).then(function(ref) {
  			ref.key();   // key for the new ly created record
			}, function(error) {
  			console.log("Error:", error);
			});
	}
	$scope.deleteRegion = function(){
		var key = $scope.area.key
		regions_sync.$remove(key);
	}


	}

	
}

controllers.UsersController = function($scope, $firebase){
	var users_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/users");
	var users_sync = $firebase(users_ref)

	$scope.getUsers = function(){
		$scope.regions = users_sync.$asArray();
	}
	$scope.getUser = function(){
		var id = $scope.user.id
		var user_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/users/"+id)
		var user_sync = $firebase(user_ref);
		$scope.user = user_sync.$asObject();
	}
	$scope.createUser = function(){
		var given_name = $scope.user.given_name;
		var family_name = $scope.family_name;
		var user = {given_name: given_name, family_name: family_name}
		users_sync.push(user).then(function(ref) {
  			ref.key();   // key for the new ly created record
			}, function(error) {
  			console.log("Error:", error);
			});
	}
	$scope.deleteUser = function(){
		var key = $scope.user.key
		users_sync.$remove(key);
	}


	}
controllers.RolesController = function($scope, $firebase){
	var roles_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/roles");
	var roles_sync = $firebase(roles_ref)

	$scope.getRoles = function(){
		$scope.roles = roles_sync.$asArray();
	}
	$scope.getRole = function(){
		var id = $scope.role.id
		var role_ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/roles/"+id)
		var role_sync = $firebase(role_ref);
		$scope.role = role_sync.$asObject();
	}
	$scope.createRole = function(){
		var name = $scope.role.name;
		var permissions = $scope.role.permissions

		var role = {name: name, permissions: permissions}
		roles_sync.push(role).then(function(ref) {
  			ref.key();   // key for the new ly created record
			}, function(error) {
  			console.log("Error:", error);
			});
	}
	$scope.deleteRole = function(){
		var key = $scope.role.key
		roles_sync.$remove(key);
	}


	}
	
}


SRA_App.controller(controllers);
}