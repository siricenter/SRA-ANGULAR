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
	var email = $scope.email
	var password = $scope.password
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
	$scope.getAreas = function(){
		var ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/areas");
		var sync = $firebase(ref);
		$scope.areas = sync.$asArray();

	}
	$scope.newArea = function(){
		 area{
		 	name: $scope.name;

		}
		var sync = $firebase(area)
	}
}

controllers.RegionsController = function($scope, $firebase){
	$scope.getAreas = function(){
		var ref = new Firebase("https://sweltering-heat-9359.firebaseio.com/regions");
		var sync = $firebase(ref);
		$scope.regions = sync.$asArray();

	}
	$scope.newRegion = function(){
		 region{
		 	name: $scope.name;

		}
		var sync = $firebase(region)
	}
}


SRA_App.controller(controllers);
