"use strict"
window.app.controller "HouseholdsController", ($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) ->
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"))
  regions = $scope.currentUser.regions
  area = $routeParams.area
  $scope.households = []
  loaded = (data) ->
    if data.Resources isnt `undefined`
      $scope.households.push data
      for family of $scope.households
        $scope.households.families = Object.keys($scope.households[family].Resources)
        familia = []
        familia = $scope.households.families
        $scope.households.familes.members = Object.keys($scope.households[family].Resources.familia[family].Members)
    return

  i = 0

  while i < regions.length
    ref = new Firebase(firebaseURL + "Organizations/SRA/Regions/" + regions[i] + "/Areas/" + area)
    sync = $firebase(ref).$asObject()
    sync.$loaded().then loaded
    i++
  $scope.ViewMembers = ->

  return
