angular.module('sraAngularApp')
  .controller('regionsIndexCtrl', ['$window', '$scope', '$http', 'firebaseURL', '$firebase', 
    function ($window, $scope, $http, firebaseURL, $firebase) {
    'use strict';

    // private variables
    var regionsURL = '';
    var firebaseRef = '';

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      firebaseRef = new $window.Firebase(firebaseURL + 'Organizations/SRA/Regions');
      console.log(firebaseURL + 'Organizations/SRA/Regions');
      $scope.regions  = $firebase(firebaseRef).$asArray();
    };

    $scope.getRegions = function() {
      $http.get(regionsURL + '.json').success(function(data, status, headers, config) {
        console.dir(data);
        $scope.regions = data;
      });
    };

    $scope.encode = function(url) {
      return url.replace(/ /gi, '%20');
    };

    $scope.init();
  }]);



angular.module('sraAngularApp')
  .controller('regionShowCtrl', ['$scope', '$http', 'firebaseURL', '$routeParams', function ($scope, $http, firebaseURL, $routeParams) {
    'use strict';
    // variables
    $scope.region = '';
    var regionURL = '';

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      regionURL = firebaseURL + 'Organizations/Organization/Regions/' + $routeParams.name;
      console.log($routeParams.name);
      $scope.region = $routeParams.name;
    };

    $scope.init();
  }]);

  angular.module('sraAngularApp')
  .controller('regionNewCtrl', ['$scope', '$http', 'firebaseURL', function ($scope, $http, firebaseURL) {
    'use strict';
    // variables
    $scope.region = '';
    var regionURL = '';
    $scope.name = '';
    $scope.errors = [];

    /**
    * for validating and submitting html forms
    */
    $scope.submit = function() {
      
    };

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      regionURL = firebaseURL + 'Organizations/Organization/Regions/';
    };

    $scope.init();
  }]);

  angular.module('sraAngularApp')
  .controller('regionEditCtrl', ['$scope', '$http', 'firebaseURL', '$routeParams', function ($scope, $http, firebaseURL, $routeParams) {
    'use strict';

    // variables
    $scope.region = '';
    var regionURL = '';
    $scope.name = '';
    $scope.errors = [];

    /**
    * for validating and submitting html forms
    */
    $scope.submit = function() {
      
    };

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      regionURL = firebaseURL + 'Organizations/Organization/Regions/' + $routeParams.name;
      console.log($routeParams.name);
      $scope.region = $routeParams.name;
    };

    $scope.init();
  }]);