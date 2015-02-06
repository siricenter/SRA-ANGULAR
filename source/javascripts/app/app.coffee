"use strict"

window.app = angular.module("sraAngularApp", [
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
	).when("/login",
		templateUrl: "/htmls/login/login.html"
		controller: "LoginController"
	).when("/admin/regions",
		templateUrl: "htmls/regions/index.html"
		controller: "regionsIndexController"
	).when("/admin/regions/show/:name",
		templateUrl: "htmls/regions/show.html"
		controller: "regionShowCtrl"
	).when("/admin/regions/new",
		templateUrl: "htmls/regions/new.html"
		controller: "regionNewCtrl"
	).when("/admin/regions/edit/:name",
		templateUrl: "htmls/regions/edit.html"
		controller: "regionEditCtrl"
	).when("/dashboard",
		templateUrl: "htmls/dashboard/worker.html"
		controller: "DashboardController"
	).when("/admin/dashboard",
		templateUrl: "htmls/dashboard/admin.html"
		controller: "AdminDashboardController"
	).when("/admin/areas",
		templateUrl: "htmls/admin/areas.html"
		controller: "AdminAreasController"
	).when("/admin/users/new",
		templateUrl: "htmls/users/new.html"
		controller: "NewUsersController"
	).when("/admin/users",
		templateUrl: "htmls/admin/users.html"
		controller: "AdminUsersController"
	).when("/admin/users/:id/edit",
		templateUrl: "htmls/admin/edit_user.html"
		controller: "EditUsersController"
	).when("/admin/users/areas/:id",
		templateUrl: "htmls/users/region.html"
		controller: "AreasUsersController"
	).when("/users/area-assignment/:name",
		templateUrl: "htmls/users/area.html"
		controller: "AreasUsersController"
	).when("/areas/new",
		templateUrl: "htmls/areas/new.html"
		controller: "AreasNewController"
	).when("/admin/users/:id/country-assignment",
		templateUrl: "htmls/admin/country-assignment.html"
		controller: "AreasUsersController"
	).when("/admin/users/:name/destroy",
		templateUrl: "htmls/admin/delete_user.html"
		controller: "DeleteUsersController"
	).when("/admin/assign/country/:country",
		templateUrl: "htmls/admin/region-assignment.html"
		controller: "AreasUsersController"
	).when("/areas",
		templateUrl: "htmls/areas/index.html"
		controller: "AreasIndexController"
	).when("/admin/assign/area/:region",
		templateUrl: "htmls/admin/area-assignment.html"
		controller: "AreasUsersController"
	).when("/areas/show/:name",
		templateUrl: "htmls/areas/show.html"
		controller: "AreasShowController"
	).when("/admin/areas/edit/:region/:name",
		templateUrl: "htmls/areas/editform.html"
		controller: "AreasEditController"
	).when("/users/areas/assignment/:area",
		templateUrl: "htmls/areas/static.html"
		controller: "AreasUsersController"
	).when("/admin/householdsindex",
		templateUrl: "htmls/admin/households.html"
		controller: "AdminHouseholdsController"
	).when("/households/:id",
		templateUrl: "htmls/households/show.html"
		controller: "HouseholdsController"
	).when("/roles/:id",
		templateUrl: "htmls/admin/user_roles.html"
		controller: "EditUsersController"
	).when("/admin/roles/new",
		templateUrl: "htmls/admin/new_role.html"
		controller: "AdminSecurityController"
	).when("/admin/roles/new/permissions/:title",
		templateUrl: "htmls/admin/add_permissions.html"
		controller: "AdminSecurityController"
	).when("/admin/security",
		templateUrl: "htmls/admin/security.html"
		controller: "AdminSecurityController"
	).otherwise redirectTo: "/"
	return

