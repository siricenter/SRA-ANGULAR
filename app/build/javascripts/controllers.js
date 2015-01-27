(function() {
  "use strict";
  window.app.controller("AdminAreasController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var areasArr, callMe, i, ref, regions, sync;
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    regions = JSON.parse(localStorage.regions);
    if (regions !== undefined) {
      callMe = function(areaData) {
        var areas;
        areasArr.push(areaData);
        areas = [];
        $scope.areas = areas.concat.apply(areas, areasArr);
      };
      i = 0;
      while (i < regions.length) {
        ref = new Firebase(firebaseURL + "Organizations/sra/regions/" + regions[i] + "/areas");
        sync = $firebase(ref).$asArray();
        areasArr = [];
        sync.$loaded().then(callMe);
        i++;
      }
    }
  });

  window.app.controller("AdminDashboardController", function($scope, $location, $firebase, $routeParams, $rootScope, orgBuilder) {
    $rootScope.title = "Dashboard";
    $scope.fromService = orgBuilder.getHouseholdsFromOrg();
    console.log($scope.fromService);
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $rootScope.sra = JSON.parse(localStorage.sra);
    $scope.firstName = $rootScope.currentUser.firstName;
    $scope.lastName = $rootScope.currentUser.lastName;
    console.log($scope.firstName);
  });

  window.app.controller("AdminUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var ref, users;
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.users = [];
    ref = new Firebase(firebaseURL + "organizations/sra/users");
    users = $firebase(ref).$asArray();
    users.$loaded().then(function(data) {
      var fb, sync, user, _i, _len;
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        user = data[_i];
        fb = new Firebase(firebaseURL + "users/" + user.$id);
        sync = $firebase(fb).$asObject();
        sync.$loaded().then(function(userObj) {
          console.log(userObj);
          if (userObj.email !== void 0) {
            return $scope.users.push(userObj);
          }
        });
      }
    });
  });

  window.app.controller("EditUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.username = $routeParams.id;
    $scope.UpdateUser = function() {
      var fname, lname, ref, sync;
      fname = $scope.user.fname;
      lname = $scope.user.lname;
      ref = new Firebase(firebaseURL + "organizations/sra/users/" + $scope.username);
      sync = $firebase(ref);
      sync.$update({
        FirstName: fname,
        LastName: lname
      }).then((function(ref) {
        ref.key();
      }), function(error) {});
    };
  });

  window.app.controller("AreasUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var countries, countryRef;
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    if ($routeParams.region !== undefined) {
      localStorage.regionParam = $routeParams.region;
    }
    if ($routeParams.id !== undefined) {
      localStorage.usernameParam = $routeParams.id;
    }
    if ($routeParams.area !== undefined) {
      localStorage.areaParam = $routeParams.area;
    }
    if ($routeParams.country !== 'undefined') {
      localStorage.countryParam = $routeParams.country;
    }
    $scope.region = localStorage.regionParam;
    $scope.username = localStorage.usernameParam;
    $scope.area = localStorage.areaParam;
    $scope.country = localStorage.countryParam;
    $scope.areaNames = [];
    $scope.areas = [];
    countryRef = new Firebase(firebaseURL + "organizations/sra/countries");
    countries = $firebase(countryRef).$asArray();
    countries.$loaded().then(function(data) {
      $scope.countries = data;
    });
    $scope.regionInit = function() {
      var ref, regions;
      ref = new Firebase(firebaseURL + "organizations/sra/countries/" + $scope.country + "/regions");
      regions = $firebase(ref).$asArray();
      return regions.$loaded().then(function(data) {
        $scope.regions = data;
      });
    };
    $scope.regionAssign = function() {
      var ref, sync;
      console.log($scope.country);
      console.log($scope.region);
      ref = new Firebase(firebaseURL + "organizations/sra/countries/" + $scope.country + "/regions/" + $scope.region + "/areas");
      sync = $firebase(ref).$asArray();
      sync.$loaded().then(function(data) {
        $scope.areas = data;
        console.log($scope.areas);
      });
    };
    $scope.areaAssignment = function() {
      var ref, sync;
      console.log($scope.areaNames);
      console.log($scope.username);
      console.log($scope.country);
      ref = new Firebase(firebaseURL + "users/" + $scope.username + "/organizations/sra/countries/" + $scope.country + "/regions");
      sync = $firebase(ref).$asArray();
      sync.$loaded().then(function(data) {
        console.log(data);
      });
    };
  });

  window.app.controller("NewUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, $firebaseAuth, firebaseURL) {
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.CreateUser = function() {
      var email, fname, lname, password, ref, userNode;
      userNode = new Firebase(firebaseURL + "organizations/sra/users");
      email = $scope.user.email;
      password = $scope.user.password;
      fname = $scope.user.fname;
      lname = $scope.user.lname;
      ref = new Firebase(firebaseURL);
      $scope.authObj = $firebaseAuth(ref);
      $scope.authObj.$createUser(email, password).then(function() {
        userNode.push(userNode.child(email.split("@")[0]).set({
          FirstName: fname,
          LastName: lname
        }));
        return $scope.authObj.$authWithPassword({
          email: email,
          password: email
        });
      })["catch"](function(error) {
        console.error("Error: ", error);
      });
    };
  });

  window.app.controller("AreasNewController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var areas, areasRef, ref, region;
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.regions = JSON.parse(localStorage.getItem("regions"));
    region = $routeParams.name;
    $scope.region = $routeParams.name;
    ref = new Firebase(firebaseURL + "organizations/sra/regions/" + region + "/areas");
    areasRef = new Firebase(firebaseURL + "organizations/sra/regions/" + region);
    areas = $firebase(areasRef).$asArray();
    areas.$loaded(function() {
      $scope.areas = areas[0];
    });
    $scope.CreateArea = function() {
      var name;
      name = $scope.area.name;
      ref.push(ref.child(name).set({
        Name: name
      }));
    };
  });

  window.app.controller("AreasEditController", function($scope, $location, $firebase, $routeParams, firebaseURL) {
    $scope.area = $routeParams.name;
    $scope.region = $routeParams.region;
    $scope.UpdateArea = function() {
      var name, ref;
      ref = new Firebase(firebaseURL + "organizations/sra/regions/" + $scope.region + "/areas/" + $scope.area);
      name = $scope.area.name;
      ref.set(name);
    };
  });

  window.app.controller("AdminHouseholdsController", function($scope, $rootScope, $location, $firebase, $routeParams, firebaseURL, orgBuilder) {
    $scope.fromService = orgBuilder.getHouseholdsFromOrg();
    console.log($rootScope.households);
  });

}).call(this);

(function() {
  "use strict";
  window.app.controller("AreasController", function($scope, $location, $firebase, $routeParams, $rootScope) {
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.regions = $rootScope.currentUser.regions;
    $scope.areas = $rootScope.currentUser.areas;
  });

  window.app.controller("AreasIndexController", function($scope, $location, $firebase, $rootScope) {
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.areas = $rootScope.currentUser.areas;
  });

  window.app.controller("AreasShowController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var area, name, ref;
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    name = $routeParams.name;
    ref = new Firebase(firebaseURL + "organizations/sra/regions/South%20Africa/areas/" + name);
    area = $firebase(ref).$asObject();
    area.$loaded().then(function(data) {
      var Household, family, members, names;
      Household = function(family, members) {
        this.family = family;
        this.members = members;
      };
      names = Object.keys(data.Resources);
      $scope.households = [];
      for (family in names) {
        members = Object.keys(data.Resources[names[family]].Members);
        $scope.households[family] = new Household(names[family], members);
      }
    });
  });

}).call(this);

(function() {
  "use strict";
  window.app.controller("HouseholdsController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    var area, i, loaded, ref, regions, sync;
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    regions = $scope.currentUser.regions;
    area = $routeParams.area;
    $scope.households = [];
    loaded = function(data) {
      var familia, family;
      if (data.Resources !== undefined) {
        $scope.households.push(data);
        for (family in $scope.households) {
          $scope.households.families = Object.keys($scope.households[family].resources);
          familia = [];
          familia = $scope.households.families;
          $scope.households.familes.members = Object.keys($scope.households[family].resources.familia[family].members);
        }
      }
    };
    i = 0;
    while (i < regions.length) {
      ref = new Firebase(firebaseURL + "organizations/sra/regions/" + regions[i] + "/areas/" + area);
      sync = $firebase(ref).$asObject();
      sync.$loaded().then(loaded);
      i++;
    }
    $scope.ViewMembers = function() {};
  });

}).call(this);

(function() {
  window.app.controller("LoginController", function($scope, $location, $rootScope, $firebase, firebaseURL, $firebaseAuth, orgBuilder) {
    var loginFunction;
    $rootScope.title = "Login";
    loginFunction = void 0;
    loginFunction = function() {
      var email, password, ref;
      email = $scope.user.email;
      password = $scope.user.password;
      ref = new Firebase(firebaseURL);
      $scope.authObj = $firebaseAuth(ref);
      $scope.authObj.$authWithPassword({
        email: email,
        password: password
      }).then(function() {
        var node, userObj, userRef;
        node = email.split("@");
        userRef = new Firebase(firebaseURL + "users/" + node[0]);
        userObj = $firebase(userRef).$asObject();
        userObj.$loaded().then(function(data) {
          $scope.fromService = orgBuilder.userCache(data);
        }).then(function() {
          if ($rootScope.currentUser.organizations.roles !== undefined) {
            if ($rootScope.currentUser.organizations.roles.name === "admin") {
              $scope.fromService = orgBuilder.orgCache(firebaseURL);
              $location.path("/admin/dashboard");
              $scope.$apply();
            } else if ($rootScope.currentUser.organizations.roles.name === "developer") {
              $location.path("/dashboard");
              $scope.$apply();
            } else {
              $location.path("/dashboard");
            }
          }
        });
      })["catch"](function(error) {
        console.error("Authentication Failed:", error);
      });
    };
    $scope.submit = loginFunction;
  });

  window.app.controller("DashboardController", function($scope, $location, $firebase, $rootScope) {
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $rootScope.title = "Dashboard";
    $scope.user = $rootScope.currentUser;
    $scope.areas = $rootScope.currentUser.areas;
    $scope.firstname = $rootScope.currentUser.firstname;
    $scope.lastname = $rootScope.currentUser.lastname;
    if ($rootScope.currentUser.roles === "Admin") {
      $location.path("/admin/dashboard");
      $scope.$apply();
    }
  });

}).call(this);

(function() {
  window.app.controller("regionsIndexController", [
    "$window", "$scope", "$http", "firebaseURL", "$firebase", function($window, $scope, $http, firebaseURL, $firebase) {
      "use strict";
      var firebaseRef, regionsURL;
      regionsURL = "";
      firebaseRef = "";

      /**
      init() acts as a constructor for the controller.
       */
      $scope.init = function() {
        regionsURL = firebaseURL + "organizations/sra/regions";
        firebaseRef = new $window.Firebase(regionsURL);
        $scope.regions = $firebase(firebaseRef).$asArray();
      };
      $scope.encode = function(url) {
        return url.replace(RegExp(" ", "g"), "%20");
      };
      return $scope.init();
    }
  ]);


  /**
   */

  window.app.controller("regionShowCtrl", [
    "$scope", "$http", "firebaseURL", "$routeParams", "$window", "$firebase", function($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
      "use strict";
      var firebaseRef, regionURL;
      regionURL = "";
      firebaseRef = "";

      /**
      init() acts as a constructor for the controller.
       */
      $scope.init = function() {
        regionURL = firebaseURL + "organizations/sra/regions/" + $routeParams.name.replace(RegExp(" ", "g"), "%20");
        firebaseRef = new $window.Firebase(regionURL);
        $scope.region = $firebase(firebaseRef).$asObject();
      };
      return $scope.init();
    }
  ]);

  window.app.controller("regionNewCtrl", [
    "$scope", "$http", "firebaseURL", "$window", "$firebase", function($scope, $http, firebaseURL, $window, $firebase) {
      "use strict";
      var URL, firebaseRef, sync;
      URL = firebaseURL + "organizations/sra/regions/";
      firebaseRef = new $window.Firebase(URL);
      sync = $firebase(firebaseRef);
      $scope.errors = [];

      /**
      for validating and submitting html forms
       */
      return $scope.submit = function() {
        if ($scope.newName !== "undefined" && $scope.newName !== "") {
          sync.$push($scope.newName);
        }
      };
    }
  ]);

  window.app.controller("regionEditCtrl", [
    "$scope", "$http", "firebaseURL", "$routeParams", "$window", "$firebase", function($scope, $http, firebaseURL, $routeParams, $window, $firebase) {
      "use strict";
      var firebaseRef, regionURL;
      regionURL = firebaseURL + "organizations/sra/regions/" + $routeParams.name.replace(RegExp(" ", "g"), "%20");
      firebaseRef = new $window.Firebase(regionURL);
      $scope.region = $firebase(firebaseRef).$asObject();
      $scope.errors = [];

      /**
      for validating and submitting html forms
       */
      return $scope.submit = function() {
        if ($scope.newName !== "undefined" && $scope.newName !== "") {
          $scope.region.$id = $scope.newName;
          $scope.region.$save();
        }
      };
    }
  ]);

}).call(this);
