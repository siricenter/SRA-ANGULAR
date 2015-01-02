angular.module('sraAngularApp')
.controller('HouseholdsController', function ($scope,$location,$firebase,$routeParams,$rootScope){
  $rootScope.current_user = JSON.parse(sessionStorage.getItem('user'));
  var regions = $scope.current_user.regions
  var area = $routeParams.area
  $scope.households = []

  for(var i = 0; i < regions.length; i++){
      var ref = new Firebase('https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Regions/' + regions[i] + '/Areas/'+ area)
      var sync = $firebase(ref).$asObject();
      sync.$loaded().then(function(data){
        
        if(data.Resources != undefined){
          $scope.households.push(data)
          for(var family in $scope.households){
            $scope.households.families = Object.keys($scope.households[family].Resources)
            var familia = []
            familia = $scope.households.families
            $scope.households.familes.members = Object.keys($scope.households[family].Resources.familia[family].Members)
          }
        }


      })
      console.log($scope.households)
  

      }

    $scope.ViewMembers = function(){

    }
  


});