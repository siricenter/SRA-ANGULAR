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
  .controller('regionsCtrl', ["$scope", function ($scope) {
    $scope.name;
  }]);