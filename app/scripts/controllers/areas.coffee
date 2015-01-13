"use strict"
window.app.controller "AreasController", ($scope, $location, $firebase, $routeParams, $rootScope) ->
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"))
  $scope.regions = $rootScope.currentUser.regions
  $scope.areas = $rootScope.currentUser.areas
  return

window.app.controller "AreasIndexController", ($scope, $location, $firebase, $rootScope) ->
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"))
  $scope.areas = $rootScope.currentUser.areas
  return

window.app.controller "AreasShowController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) ->
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"))
  name = $routeParams.name
  ref = new Firebase(firebaseURL + "Organizations/SRA/Regions/South%20Africa/Areas/" + name)
  area = $firebase(ref).$asObject()
  area.$loaded().then (data) ->
    Household = (family, members) ->
      @family = family
      @members = members
      return
    names = Object.keys(data.Resources)
    $scope.households = []
    
    # var list = []; // Defined, but never used.
    for family of names
      members = Object.keys(data.Resources[names[family]].Members)
      $scope.households[family] = new Household(names[family], members)
    return

  return
