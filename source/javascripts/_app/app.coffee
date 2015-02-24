"use strict"

window.app = angular.module("sraAngularApp", [
	"ngAnimate"
	"ngAria"
	"ngCookies"
	"ngMessages"
	"ngResource"
	"ngRoute"
	"ngSanitize"
	"ngTouch"
	"firebase"
])

window.app.config ($routeProvider) ->
	$routeProvider.when("/",
		templateUrl: "/htmls/login/login.html"
		controller: "LoginController"
	).when( "/admin/dashboard",
		templateUrl: "/htmls/dashboard/admin.html",
		controller: "AdminDashboardController"
	).when("/admin/dashboard",
		templateUrl: "/htmls/dashboard/admin.html"
		controller: "AdminDashboardController"
	).when("/admin/users",
		templateUrl: "htmls/admin/users.html"
		controller: "AdminUsersController"
	).when("/admin/users/:name/destroy",
		templateUrl: "htmls/admin/delete_user.html"
		controller: "DeleteUsersController"
	).when("/admin/users/:id/edit",
		templateUrl: "htmls/admin/edit_user.html"
		controller: "EditUsersController"
	).when("/admin/users/new",
		templateUrl: "htmls/users/new.html",
		controller: "NewUsersController"
	).when("/roles/:id",
		templateUrl: "htmls/admin/user_roles.html"
		controller: "EditUsersController"
	).when("/admin/householdsindex",
		templateUrl: "htmls/admin/households.html"
		controller: "AdminHouseholdsController"
	).when("/admin/security",
		templateUrl: "htmls/admin/security.html"
		controller: "AdminSecurityController"
	).when("/admin/roles/new",
		templateUrl: "htmls/admin/new_role.html"
		controller: "AdminSecurityController"
	).when("/admin/roles/new/permissions/:title",
		templateUrl: "htmls/admin/add_permissions.html"
		controller: "AdminSecurityController"
	).when("/questionsManager",
		templateUrl: "htmls/admin/questionsAdmin.html"
		controller: "QuestionsAdminController"
	).when("/countries",
		templateUrl: "htmls/countries/index.html"
		controller: "CountriesIndexController"
	).when("/countries/new",
		templateUrl: "htmls/countries/new.html"
		controller: "NewCountryController"
	).when("/countries/:countryId",
		templateUrl: "htmls/countries/show.html"
		controller: "ShowCountryController"
	).when("/regions",
		templateUrl: "htmls/regions/index.html"
		controller: "RegionsIndexController"
	).when("/regions/new",
		templateUrl: "htmls/regions/new.html"
		controller: "NewRegionController"
	).otherwise redirectTo: "/"
	
	return

