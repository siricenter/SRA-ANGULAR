(function() {
  window.app.controller("regionsIndexController", [
    "$window", "$scope", "$http", "firebaseURL", "$firebase", function($window, $scope, $http, firebaseURL, $firebase) {
      "use strict";
      var firebaseRef, regionsURL;
      regionsURL = "";
      firebaseRef = "";

      /**
      init() acts as a constructor for the controller.
       */
      $scope.init = function() {
        regionsURL = firebaseURL + "organizations/sra/regions";
        firebaseRef = new $window.Firebase(regionsURL);
        $scope.regions = $firebase(firebaseRef).$asArray();
      };
      $scope.encode = function(url) {
        return url.replace(RegExp(" ", "g"), "%20");
      };
      return $scope.init();
    }
  ]);


  /**
   */

  window.app.controller("regionShowCtrl", [
    "$scope", "$http", "firebaseURL", "$routeParams", "$window", "$firebase", function($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
      "use strict";
      var firebaseRef, regionURL;
      regionURL = "";
      firebaseRef = "";

      /**
      init() acts as a constructor for the controller.
       */
      $scope.init = function() {
        regionURL = firebaseURL + "organizations/sra/regions/" + $routeParams.name.replace(RegExp(" ", "g"), "%20");
        firebaseRef = new $window.Firebase(regionURL);
        $scope.region = $firebase(firebaseRef).$asObject();
      };
      return $scope.init();
    }
  ]);

  window.app.controller("regionNewCtrl", [
    "$scope", "$http", "firebaseURL", "$window", "$firebase", function($scope, $http, firebaseURL, $window, $firebase) {
      "use strict";
      var URL, firebaseRef, sync;
      URL = firebaseURL + "organizations/sra/regions/";
      firebaseRef = new $window.Firebase(URL);
      sync = $firebase(firebaseRef);
      $scope.errors = [];

      /**
      for validating and submitting html forms
       */
      return $scope.submit = function() {
        if ($scope.newName !== "undefined" && $scope.newName !== "") {
          sync.$push($scope.newName);
        }
      };
    }
  ]);

  window.app.controller("regionEditCtrl", [
    "$scope", "$http", "firebaseURL", "$routeParams", "$window", "$firebase", function($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
      "use strict";
      var firebaseRef, regionURL;
      regionURL = firebaseURL + "organizations/sra/regions/" + $routeParams.name.replace(RegExp(" ", "g"), "%20");
      firebaseRef = new $window.Firebase(regionURL);
      $scope.region = $firebase(firebaseRef).$asObject();
      $scope.errors = [];

      /**
      for validating and submitting html forms
       */
      return $scope.submit = function() {
        if ($scope.newName !== "undefined" && $scope.newName !== "") {
          $scope.region.$id = $scope.newName;
          $scope.region.$save();
        }
      };
    }
  ]);

}).call(this);
