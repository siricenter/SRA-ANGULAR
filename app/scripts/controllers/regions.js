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
      regionsURL = firebaseURL + 'Organizations/SRA/Regions';
      firebaseRef = new $window.Firebase(regionsURL);
      console.log(regionsURL);
      $scope.regions  = $firebase(firebaseRef).$asArray();
    };


    $scope.encode = function(url) {
      return url.replace(/ /gi, '%20');
    };

    $scope.init();
  }]);



angular.module('sraAngularApp')
  .controller('regionShowCtrl', ['$scope', '$http', 'firebaseURL', '$routeParams', '$window', '$firebase', 
    function ($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
    'use strict';
    // variables
    // private variables
    var regionURL = '';
    var firebaseRef = '';

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      regionURL = firebaseURL + 'Organizations/SRA/Regions/' + $routeParams.name.replace(/ /gi, '%20');
      console.log(regionURL);
      firebaseRef = new $window.Firebase(regionURL);
      $scope.region  = $firebase(firebaseRef).$asObject();
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