'use strict';

/**
 * @ngdoc overview
 * @name sraAngularApp
 * @description
 * # sraAngularApp
 *
 * Main module of the application.
 */
angular
  .module('sraAngularApp', [
    'ngAnimate',
    'ngAria',
    'ngCookies',
    'ngMessages',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'firebase'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/static/landing.html',
        controller: ''
      })
      .when('/login', {
        templateUrl: 'views/sessions/new.html',
        controller: 'LoginController'
      })
      .when('/regions', {
        templateUrl: 'views/regions/index.html',
        controller: 'regionsCtrl'
      })
      .when('/dashboard', {
        templateUrl: 'views/dashboard/worker.html',
        controller: 'DashboardController'
      })
      .when('/areas', {
        templateUrl: 'views/areas/index.html',
        controller: 'DashboardController'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
