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
	).otherwise redirectTo: "/"
	return

