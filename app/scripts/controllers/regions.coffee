window.app.controller "regionsIndexCtrl", [
  "$window"
  "$scope"
  "$http"
  "firebaseURL"
  "$firebase"
  ($window, $scope, $http, firebaseURL, $firebase) ->
    "use strict"
    
    # private variables
    regionsURL = ""
    firebaseRef = ""
    
    ###*
    init() acts as a constructor for the controller.
    ###
    $scope.init = ->
      regionsURL = firebaseURL + "Organizations/SRA/Regions"
      firebaseRef = new $window.Firebase(regionsURL)
      console.log regionsURL
      $scope.regions = $firebase(firebaseRef).$asArray()
      return

    $scope.encode = (url) ->
      url.replace RegExp(" ", "g"), "%20"

    $scope.init()
]

###*
###
window.app.controller "regionShowCtrl", [
  "$scope"
  "$http"
  "firebaseURL"
  "$routeParams"
  "$window"
  "$firebase"
  ($scope, $http, firebaseURL, $routeParams, $window, $firebase) ->
    "use strict"
    
    # variables
    # private variables
    regionURL = ""
    firebaseRef = ""
    
    ###*
    init() acts as a constructor for the controller.
    ###
    $scope.init = ->
      regionURL = firebaseURL + "Organizations/SRA/Regions/" + $routeParams.name.replace(RegExp(" ", "g"), "%20")
      console.log regionURL
      firebaseRef = new $window.Firebase(regionURL)
      $scope.region = $firebase(firebaseRef).$asObject()
      return

    $scope.init()
]
window.app.controller "regionNewCtrl", [
  "$scope"
  "$http"
  "firebaseURL"
  "$window"
  "$firebase"
  ($scope, $http, firebaseURL, $window, $firebase) ->
    "use strict"
    
    # variables
    URL = firebaseURL + "Organizations/SRA/Regions/"
    firebaseRef = new $window.Firebase(URL)
    sync = $firebase(firebaseRef)
    $scope.errors = []
    
    ###*
    for validating and submitting html forms
    ###
    $scope.submit = ->
      if $scope.newName isnt "undefined" and $scope.newName isnt ""
        console.log "name:" + $scope.newName
        sync.$push $scope.newName
      return
]
window.app.controller "regionEditCtrl", [
  "$scope"
  "$http"
  "firebaseURL"
  "$routeParams"
  "$window"
  "$firebase"
  ($scope, $http, firebaseURL, $routeParams, $window, $firebase) ->
    "use strict"
    
    # variables
    regionURL = firebaseURL + "Organizations/SRA/Regions/" + $routeParams.name.replace(RegExp(" ", "g"), "%20")
    firebaseRef = new $window.Firebase(regionURL)
    $scope.region = $firebase(firebaseRef).$asObject()
    $scope.errors = []
    
    ###*
    for validating and submitting html forms
    ###
    $scope.submit = ->
      if $scope.newName isnt "undefined" and $scope.newName isnt ""
        console.log "name:" + $scope.newName
        $scope.region.$id = $scope.newName
        $scope.region.$save()
      return
]