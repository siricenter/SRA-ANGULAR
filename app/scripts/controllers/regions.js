angular.module('sraAngularApp')
  .controller('regionsIndexCtrl', ['$scope', '$http', 'firebaseURL', function ($scope, $http, firebaseURL) {

    // variables
    $scope.regions = '';
    var regionsURL = '';

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      regionsURL = firebaseURL + 'Organizations/Organization/Regions';
      $scope.getRegions();
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