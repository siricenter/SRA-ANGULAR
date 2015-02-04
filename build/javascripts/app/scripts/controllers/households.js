(function() {
  "use strict";
  window.app.controller("HouseholdsController", function($scope, $routeParams, $firebase, firebaseURL, currentUser) {
    return currentUser.currentUser().then(function(user) {
      var area, i, loaded, ref, regions, sync;
      regions = user.regions;
      area = $routeParams.area;
      $scope.households = [];
      loaded = function(area) {
        var familia, family;
        if (area.resources != null) {
          $scope.households.push(area);
          for (family in $scope.households) {
            $scope.households.families = Object.keys($scope.households[family].resources);
            familia = [];
            familia = $scope.households.families;
            $scope.households.familes.members = Object.keys($scope.households[family].resources.familia[family].members);
          }
        }
      };
      i = 0;
      while (i < regions.length) {
        ref = new Firebase(firebaseURL + "organizations/sra/regions/" + regions[i] + "/areas/" + area);
        sync = $firebase(ref).$asObject();
        sync.$loaded().then(loaded);
        i++;
      }
      $scope.ViewMembers = function() {};
    });
  });

}).call(this);
