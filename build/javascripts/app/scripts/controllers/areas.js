(function() {
  "use strict";
  window.app.controller("AreasController", function($scope, $location, $firebase, $routeParams, $rootScope, currentUser) {
    $scope.regions = currentUser.currentUser().regions;
    $scope.areas = $rootScope.currentUser.areas;
  });

  window.app.controller("AreasIndexController", function($scope, $location, $firebase, $rootScope, currentUser) {
    $scope.areas = currentUser.currentUser().areas;
  });

  window.app.controller("AreasShowController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var area, name, ref;
    name = $routeParams.name;
    ref = new Firebase(firebaseURL + "organizations/sra/regions/South%20Africa/areas/" + name);
    area = $firebase(ref).$asObject();
    area.$loaded().then(function(area) {
      var Household, family, members, names;
      Household = function(family, members) {
        this.family = family;
        this.members = members;
      };
      names = Object.keys(area.resources);
      $scope.households = [];
      for (family in names) {
        members = Object.keys(area.resources[names[family]].members);
        $scope.households[family] = new Household(names[family], members);
        return;
      }
    });
  });

  window.app.controller("AreasNewController", function($scope, $rootScope, currentUser, $firebase) {
    currentUser.requireLogin().then(function() {
      var fb, things;
      fb = new Firebase('https://testrbdc.firebaseio.com/things');
      things = $firebase(fb.orderByChild('name').startAt('anotherthing').endAt('athing')).$asArray();
      return things.$loaded().then(function(things) {
        return $scope.things = things;
      });
    });
  });

}).call(this);
