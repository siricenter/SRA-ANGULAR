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
	).when( "/admin/edit/role/:title",
		templateUrl: "/htmls/admin/edit_role.html",
		controller: "AdminSecurityController"
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
	).when("/households",
		templateUrl: "htmls/households/index.html"
		controller: "HouseholdsIndexController"
	).when("/households/:householdId",
		templateUrl: "htmls/households/show.html"
		controller: "ShowHouseholdController"
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
		templateUrl: "htmls/admin/questions_admin.html"
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
	).when("/regions/:regionId",
		templateUrl: "htmls/regions/show.html"
		controller: "ShowRegionController"
	).when("/areas",
		templateUrl: "htmls/areas/index.html"
		controller: "AreasIndexController"
	).when("/areas/new",
		templateUrl: "htmls/areas/new.html"
		controller: "NewAreaController"
	).when("/areas/:areaId",
		templateUrl: "htmls/areas/show.html"
		controller: "ShowAreaController"
	).otherwise redirectTo: "/"
	
	return

