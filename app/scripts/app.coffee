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
window.app.service "OrgBuilder", ($firebase, $rootScope) ->
	@orgCache = (ref) ->
		fireRef = new Firebase(ref + "Organizations/SRA")
		org = $firebase(fireRef).$asObject()
		org.$loaded().then (data) ->
			sra = {}
			sra.id = data.$id
			sra.Countries = []
			sra.Countries = data.Countries
			sra["Question Sets"] = data["Question Sets"]
			sra.Roles = data.Roles
			sra.Users = data.Users
			localStorage.setItem "SRA", JSON.stringify(sra)
			return

		return

	@userCache = (obj) ->
		user = undefined
		storedUser = undefined
		user = {}
		user.email = obj.Email
		user.firstName = obj["First Name"]
		user.lastName = obj["Last Name"]
		user.organizations = obj.Organizations.SRA
		sessionStorage.setItem "user", JSON.stringify(user)
		storedUser = sessionStorage.getItem("user")
		$rootScope.currentUser = {}
		$rootScope.currentUser = JSON.parse(storedUser)
		return

	@getAreasFromRegion = (region) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + region.Country + "/Regions/" + region.Name + "/Areas")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data


	@getRegionsFromCountry = (country) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + country + "/Regions")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data


	@getCountriesFromOrg = ->
		countries = {}
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries")
		sync = $firebase(ref).$asArray()
		countries.data = sync.$loaded().then((data) ->
			data
		)
		countries

	@getHouseholdsFromArea = (area) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + area.Country + "/Regions/" + area.Region + "/Areas/" + area.Name + "/Resources")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then ->

			return

	@getHouseholdsFromOrg = ->
		householdsCallback = undefined
		areasCallback = undefined
		regionsCallback = undefined
		countriesCallback = undefined
		ref = undefined
		sync = undefined
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries")
		sync = $firebase(ref).$asArray()
		householdsCallback = (households) ->
			households

		areasCallback = (areas) ->
			k = 0

			while k < areas.length
				houseRef = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + areas[k].Country + "/Regions/" + areas[k].Region + "/Areas/" + areas[k].Name + "/Resources")
				houseSync = $firebase(houseRef).$asArray()
				houseSync.$loaded().then householdsCallback
				k++
			return

		regionsCallback = (regions) ->
			j = 0

			while j < regions.length
				areaRef = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + regions[j].Country + "/Regions/" + regions[j].Name + "/Areas")
				areaSync = $firebase(areaRef).$asArray()
				areaSync.$loaded().then areasCallback
				j++
			return

		countriesCallback = (countries) ->
			i = 0

			while i < countries.length
				regRef = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + countries[i].Name + "/Regions")
				regSync = $firebase(regRef).$asArray()
				regSync.$loaded().then regionsCallback
				i++
			return

		sync.$loaded().then countriesCallback
		return

	return

window.app.run ($rootScope, $firebase, firebaseURL) ->
	ref = undefined
	regionsArr = undefined
	regions = undefined
	onArrLoad = undefined
	$rootScope.currentUser = {}
	$rootScope.firebaseSession = localStorage["firebase:session::intense-inferno-7741"]
	ref = new Firebase(firebaseURL + "Organizations/SRA/Regions")
	regionsArr = $firebase(ref).$asArray()
	regions = []
	onArrLoad = ->
		for region of regionsArr
			regions.push regionsArr[region].$id	if regionsArr[region].$id isnt `undefined`
		regions = JSON.stringify(regions)
		localStorage.setItem "regions", regions
		$rootScope.regions = JSON.parse(localStorage.getItem("regions"))
		return

	regionsArr.$loaded().then onArrLoad
	return

window.app.config ($routeProvider) ->
	$routeProvider.when("/",
		templateUrl: "/build/login.html"
		controller: "LoginController"
	).when("/login",
		templateUrl: "views/sessions/new.html"
		controller: "LoginController"
	).when("/admin/regions",
		templateUrl: "views/regions/index.html"
		controller: "regionsIndexCtrl"
	).when("/admin/regions/show/:name",
		templateUrl: "views/regions/show.html"
		controller: "regionShowCtrl"
	).when("/admin/regions/new",
		templateUrl: "views/regions/new.html"
		controller: "regionNewCtrl"
	).when("/admin/regions/edit/:name",
		templateUrl: "views/regions/edit.html"
		controller: "regionEditCtrl"
	).when("/dashboard",
		templateUrl: "views/dashboard/worker.html"
		controller: "DashboardController"
	).when("/admin/dashboard",
		templateUrl: "views/dashboard/admin.html"
		controller: "AdminDashboardController"
	).when("/admin/areas",
		templateUrl: "views/admin/areas.html"
		controller: "AdminAreasController"
	).when("/admin/users/new",
		templateUrl: "views/users/new.html"
		controller: "NewUsersController"
	).when("/admin/users",
		templateUrl: "views/admin/users.html"
		controller: "AdminUsersController"
	).when("/admin/users/edit/:id",
		templateUrl: "views/users/edit.html"
		controller: "EditUsersController"
	).when("/admin/users/areas/:id",
		templateUrl: "views/users/region.html"
		controller: "AreasUsersController"
	).when("/users/area-assignment/:name",
		templateUrl: "views/users/area.html"
		controller: "AreasUsersController"
	).when("/areas/region-assignment/:name",
		templateUrl: "views/areas/new.html"
		controller: "AreasNewController"
	).when("/areas",
		templateUrl: "views/areas/index.html"
		controller: "AreasIndexController"
	).when("/admin/areas/new",
		templateUrl: "views/areas/region.html"
		controller: "AreasNewController"
	).when("/areas/show/:name",
		templateUrl: "views/areas/show.html"
		controller: "AreasShowController"
	).when("/admin/areas/edit/:region/:name",
		templateUrl: "views/areas/editform.html"
		controller: "AreasEditController"
	).when("/users/areas/assignment/:area",
		templateUrl: "views/areas/static.html"
		controller: "AreasUsersController"
	).when("/:area/households",
		templateUrl: "views/households/index.html"
		controller: "HouseholdsController"
	).when("/households/:id",
		templateUrl: "views/households/show.html"
		controller: "HouseholdsController"
	).otherwise redirectTo: "/"
	return

