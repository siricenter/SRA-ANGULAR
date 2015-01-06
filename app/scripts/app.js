'use strict';




var app = angular.module('sraAngularApp', [
		'ngAnimate',
		'ngAria',
		'ngCookies',
		'ngMessages',
		'ngResource',
		'ngRoute',
		'ngSanitize',
		'ngTouch',
		'firebase'
]);

app.service('OrgBuilder', function($firebase,$rootScope){
  this.orgCache= function(ref){
        var fireRef = new Firebase(ref + 'Organizations/SRA');
        var org = $firebase(fireRef).$asObject();
        org.$loaded().then(function(data){
          var sra = {}
          sra.id = data.$id
          sra.Countries = data.Countries
          sra['Question Sets'] = data['Question Sets']
          sra.Roles = data.Roles
          sra.Users = data.Users
          localStorage.setItem('SRA', JSON.stringify(sra))

        })
        
    }; 
  this.userCache = function(obj){
     
        // var roles = data.Organizations.SRA.Roles; // defined, but never used
       var user = {}
    
        user.email = obj.Email
        user.firstName = obj['First Name']
        user.lastName = obj['Last Name']
        user.organizations = obj.Organizations.SRA
        sessionStorage.setItem('user', JSON.stringify(user));
        var storedUser = sessionStorage.getItem('user');
        console.log(storedUser);
        $rootScope.currentUser = {};
        $rootScope.currentUser = JSON.parse(storedUser);
        console.log($rootScope.currentUser);
      
  

};
});



app.run(function ($rootScope, $firebase, firebaseURL) {

	$rootScope.currentUser = {};
	$rootScope.firebaseSession = localStorage['firebase:session::intense-inferno-7741'];
	var ref = new Firebase(firebaseURL + 'Organizations/SRA/Regions');
	var regionsArr = $firebase(ref).$asArray();
	var regions = [];
	regionsArr.$loaded().then(function (/*data*/) {
		for (var region in regionsArr) {
			if (regionsArr[region].$id !== undefined) {
				regions.push(regionsArr[region].$id);
			}
		}
		regions = JSON.stringify(regions);
		localStorage.setItem('regions', regions);
		$rootScope.regions = JSON.parse(localStorage.getItem('regions'));
	});
});

app.config(function ($routeProvider) {
	$routeProvider.when('/', {
		templateUrl: '/build/login.html',
		controller: 'LoginController'
	}).when('/login', {
		templateUrl: 'views/sessions/new.html',
		controller: 'LoginController'
	}).when('/admin/regions', {
		templateUrl: 'views/regions/index.html',
		controller: 'regionsIndexCtrl'
	}).when('/admin/regions/show/:name', {
		templateUrl: 'views/regions/show.html',
		controller: 'regionShowCtrl'
	}).when('/admin/regions/new', {
		templateUrl: 'views/regions/new.html',
		controller: 'regionNewCtrl'
	}).when('/admin/regions/edit/:name', {
		templateUrl: 'views/regions/edit.html',
		controller: 'regionEditCtrl'
	}).when('/dashboard', {
		templateUrl: 'views/dashboard/worker.html',
		controller: 'DashboardController'
	}).when('/admin/dashboard', {
		templateUrl: 'views/dashboard/admin.html',
		controller: 'AdminDashboardController'
	}).when('/admin/areas', {
		templateUrl: 'views/admin/areas.html',
		controller: 'AdminAreasController'
	}).when('/admin/users/new', {
		templateUrl: 'views/users/new.html',
		controller: 'NewUsersController'
	}).when('/admin/users', {
		templateUrl: 'views/admin/users.html',
		controller: 'AdminUsersController'
	}).when('/admin/users/edit/:id', {
		templateUrl: 'views/users/edit.html',
		controller: 'EditUsersController'
	}).when('/admin/users/areas/:id', {
		templateUrl: 'views/users/region.html',
		controller: 'AreasUsersController'
	}).when('/users/area-assignment/:name', {
		templateUrl: 'views/users/area.html',
		controller: 'AreasUsersController'
	}).when('/areas/region-assignment/:name', {
		templateUrl: 'views/areas/new.html',
		controller: 'AreasNewController'
	}).when('/areas', {
		templateUrl: 'views/areas/index.html',
		controller: 'AreasIndexController'
	}).when('/admin/areas/new', {
		templateUrl: 'views/areas/region.html',
		controller: 'AreasNewController'
	}).when('/areas/show/:name', {
		templateUrl: 'views/areas/show.html',
		controller: 'AreasShowController'
	}).when('/admin/areas/edit/:region/:name', {
		templateUrl: 'views/areas/editform.html',
		controller: 'AreasEditController'
	}).when('/users/areas/assignment/:area', {
		templateUrl: 'views/areas/static.html',
		controller: 'AreasUsersController'
	}).when('/:area/households', {
		templateUrl: 'views/households/index.html',
		controller: 'HouseholdsController'
	}).when('/households/:id', {
		templateUrl: 'views/households/show.html',
		controller: 'HouseholdsController'
	}).otherwise({ redirectTo: '/' });
});
