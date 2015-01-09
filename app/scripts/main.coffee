"use strict"

#Constants
window.app.constant "firebaseURL", "https://intense-inferno-7741.firebaseio.com/" #'https://torid-inferno-2841.firebaseio.com/'
window.app.controller "LoginController", ($scope, $location, $rootScope, $firebase, firebaseURL, OrgBuilder) ->
  $rootScope.title = "Login"
  loginFunction = undefined
  loginFunction = ->
    email = undefined
    password = undefined
    ref = undefined
    email = $scope.user.email
    password = $scope.user.password
    ref = new Firebase(firebaseURL)
    $scope.authObj = $firebaseAuth(ref)
    $scope.authObj.$authWithPassword(
      email: email
      password: password
    ).then(->
      node = undefined
      userRef = undefined
      userObj = undefined
      node = email.split("@")
      userRef = new Firebase(firebaseURL + "Users/" + node[0])
      userObj = $firebase(userRef).$asObject()
      userObj.$loaded().then((data) ->
        $scope.fromService = OrgBuilder.userCache(data)
        return
      ).then ->
        if $rootScope.currentUser.organizations.Roles isnt `undefined`
          if $rootScope.currentUser.organizations.Roles.Name is "Admin"
            $scope.fromService = OrgBuilder.orgCache(firebaseURL)
            $location.path "/admin/dashboard"
            $scope.$apply()
          else if $rootScope.currentUser.organizations.Roles.Name is "Developer"
            $location.path "/dashboard"
            $scope.$apply()
          else
            $location.path "/dashboard"
        return

      return
    ).catch (error) ->
      console.error "Authentication Failed:", error
      return

    return

  $scope.Login = loginFunction
  return

window.app.controller "DashboardController", ($scope, $location, $firebase, $rootScope) ->
  $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"))
  $scope.user = $rootScope.currentUser
  $scope.areas = $rootScope.currentUser.areas
  $scope.firstname = $rootScope.currentUser.firstName
  $scope.lastName = $rootScope.currentUser.lastName
  if $rootScope.currentUser.roles is "Admin"
    $location.path "/admin/dashboard"
    $scope.$apply()
  return
