'use strict';

/**
 * @ngdoc function
 * @name sraAngularApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the sraAngularApp
 */
angular.module('sraAngularApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });

angular.module('sraAngularApp')
  .service('sharedData', function () {
      var region;
      var area;
      var resource;

      // place getters/setters here
      return {
          getRegion: function () {
              return region;
          },
          setRegion: function(value) {
              region = value;
          },
          getArea: function() {
            return area;
          },
          setArea: function(value) {
            area = value;
          },
          getResource: function() {
            return resource;
          },
          setResource: function(value) {
            resource = value;
          }
      };
  });


/*Constants*/
angular.module('sraAngularApp').constant('firebaseURL', 'https://intense-inferno-7741.firebaseio.com/' /*'https://torid-inferno-2841.firebaseio.com/'*/);

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

    $scope.init();
  }]);



angular.module('sraAngularApp')
  .controller('regionsShowCtrl', ['$scope', '$http', 'firebaseURL', '$routeParams', function ($scope, $http, firebaseURL, $routeParams) {

    // variables
    $scope.regions = '';
    var regionURL = '';

    /**
    * init() acts as a constructor for the controller.
    */
    $scope.init = function() {
      regionURL = firebaseURL + 'Organizations/Organization/Regions/' + $routeParams.name;
      $scope.getRegion();
    };

    $scope.getRegions = function() {
      $http.get(regionURL + '.json').success(function(data, status, headers, config) {
        console.dir(data);
        $scope.region = data;
      });
    };

    $scope.init();
  }]);