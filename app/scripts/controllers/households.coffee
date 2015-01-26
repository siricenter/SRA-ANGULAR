"use strict"
window.app.controller "HouseholdsController", ($scope, $routeParams, $firebase, firebaseURL, currentUser) ->

  regions = currentUser.currentUser().regions
  area = $routeParams.area
  $scope.households = []

  loaded = (area) ->
    if area.resources?
      $scope.households.push area
      for family of $scope.households
        $scope.households.families = Object.keys($scope.households[family].resources)
        familia = []
        familia = $scope.households.families
        $scope.households.familes.members = Object.keys($scope.households[family].resources.familia[family].members)
    return

  i = 0

  while i < regions.length
    ref = new Firebase(firebaseURL + "organizations/sra/regions/" + regions[i] + "/areas/" + area)
    sync = $firebase(ref).$asObject()
    sync.$loaded().then loaded
    i++
  $scope.ViewMembers = ->

  return
