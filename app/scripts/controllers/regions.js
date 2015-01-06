window.app.controller('regionsIndexCtrl', [
  '$window',
  '$scope',
  '$http',
  'firebaseURL',
  '$firebase',
  function ($window, $scope, $http, firebaseURL, $firebase) {
    'use strict';
    // private variables
    var regionsURL = '';
    var firebaseRef = '';
    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function () {
      regionsURL = firebaseURL + 'Organizations/SRA/Regions';
      firebaseRef = new $window.Firebase(regionsURL);
      console.log(regionsURL);
      $scope.regions = $firebase(firebaseRef).$asArray();
    };
    $scope.encode = function (url) {
      return url.replace(/ /gi, '%20');
    };
    $scope.init();
  }
]);
/**
* 
*/
window.app.controller('regionShowCtrl', [
  '$scope',
  '$http',
  'firebaseURL',
  '$routeParams',
  '$window',
  '$firebase',
  function ($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
    'use strict';
    // variables
    // private variables
    var regionURL = '';
    var firebaseRef = '';
    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function () {
      regionURL = firebaseURL + 'Organizations/SRA/Regions/' + $routeParams.name.replace(/ /gi, '%20');
      console.log(regionURL);
      firebaseRef = new $window.Firebase(regionURL);
      $scope.region = $firebase(firebaseRef).$asObject();
    };
    $scope.init();
  }
]);
window.app.controller('regionNewCtrl', [
  '$scope',
  '$http',
  'firebaseURL',
  '$window',
  '$firebase',
  function ($scope, $http, firebaseURL, $window, $firebase) {
    'use strict';
    // variables
    var URL = firebaseURL + 'Organizations/SRA/Regions/';
    var firebaseRef = new $window.Firebase(URL);
    var sync = $firebase(firebaseRef);
    $scope.errors = [];
    /**
    * for validating and submitting html forms
    */
    $scope.submit = function () {
      if ($scope.newName !== 'undefined' && $scope.newName !== '') {
        console.log('name:' + $scope.newName);
        sync.$push($scope.newName);
      }
    };
  }
]);
window.app.controller('regionEditCtrl', [
  '$scope',
  '$http',
  'firebaseURL',
  '$routeParams',
  '$window',
  '$firebase',
  function ($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
    'use strict';
    // variables
    var regionURL = firebaseURL + 'Organizations/SRA/Regions/' + $routeParams.name.replace(/ /gi, '%20');
    var firebaseRef = new $window.Firebase(regionURL);
    $scope.region = $firebase(firebaseRef).$asObject();
    $scope.errors = [];
    /**
    * for validating and submitting html forms
    */
    $scope.submit = function () {
      if ($scope.newName !== 'undefined' && $scope.newName !== '') {
        console.log('name:' + $scope.newName);
        $scope.region.$id = $scope.newName;
        $scope.region.$save();
      }
    };
  }
]);