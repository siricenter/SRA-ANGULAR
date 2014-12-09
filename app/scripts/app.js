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
  ]).run(function($rootScope) {
    $rootScope.current_user = {};
    $rootScope.firebaseSession = localStorage['firebase:session::intense-inferno-7741']
})
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
        controller: 'regionsIndexCtrl'
      })
      .when('/region/show/:name', {
        templateUrl: 'views/regions/show.html',
        controller: 'regionShowCtrl'
      })
      .when('/region/new', {
        templateUrl: 'views/regions/new.html',
        controller: 'regionNewCtrl'
      })
      .when('/region/edit/:name', {
        templateUrl: 'views/regions/edit.html',
        controller: 'regionEditCtrl'
      })
      .when('/dashboard', {
        templateUrl: 'views/dashboard/worker.html',
        controller: 'DashboardController'
      })
      .when('/areas', {
        templateUrl: 'views/areas/index.html',
        controller: 'AreasIndexController'
      })
      .when('/areas/show/:name', {
        templateUrl: 'views/areas/show.html',
        controller: 'AreasShowController'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
