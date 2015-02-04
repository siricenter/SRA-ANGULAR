(function() {
  "use strict";
  window.app.controller("AdminAreasController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL, currentUser) {
    var areasArr, callMe, i, ref, regions, sync;
    currentUser.requireLogin();
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

  window.app.controller("AdminDashboardController", function($scope, $rootScope, currentUser) {
    $rootScope.title = "Dashboard";
    currentUser.requireLogin();
  });

  window.app.controller("AdminUsersController", function($scope, $rootScope, currentUser, User) {
    $rootScope.title = "Users Index";
    currentUser.requireLogin();
    User.all().then(function(users) {
      return $scope.users = users;
    });
  });

  window.app.controller("EditUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL, currentUser) {
    var rolesref, rolessync, userRef, userSync;
    currentUser.requireLogin();
    $scope.name = $routeParams.id;
    $scope.userRoles = [];
    userRef = new Firebase(firebaseURL + "/users/" + $scope.name + "/organizations/sra/roles");
    userSync = $firebase(userRef).$asArray();
    userSync.$loaded().then(function(roles) {
      var role, _i, _len;
      for (_i = 0, _len = roles.length; _i < _len; _i++) {
        role = roles[_i];
        $scope.userRoles.push(role.$value);
      }
    });
    rolesref = new Firebase(firebaseURL + "organizations/sra/roles");
    rolessync = $firebase(rolesref).$asArray();
    rolessync.$loaded().then(function(data) {
      $scope.roles = data;
    });
    $scope.updateUser = function() {
      var fname, lname, ref, sync;
      console.log("hi");
      fname = $scope.user.fname;
      lname = $scope.user.lname;
      ref = new Firebase(firebaseURL + "organizations/sra/users/" + $scope.name);
      sync = $firebase(ref);
      return sync.$update({
        firstname: fname,
        lastname: lname
      }).then(function() {
        var xref, xsync;
        xref = new Firebase(firebaseURL + "/users/" + $scope.name);
        xsync = $firebase(xref);
        xsync.$update({
          firstName: fname,
          lastName: lname
        }).then(function() {
          $location.path('/admin/users');
        });
      });
    };
    $scope.updateRole = function() {
      var role, roles, _i, _len;
      roles = $scope.userRoles;
      for (_i = 0, _len = roles.length; _i < _len; _i++) {
        role = roles[_i];
        userRef = new Firebase(firebaseURL + "/users/" + $scope.name + "/organizations/sra/roles");
        userSync = $firebase(userRef);
        userSync.$update({
          name: role
        });
        return;
      }
    };
    $scope.createPermission = function() {
      var permissions;
      return permissions = $scope.permissions;
    };
  });

  window.app.controller("DeleteUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {
    $rootScope.currentUser = JSON.parse(sessionStorage.getItem("user"));
    $scope.name = $routeParams.name;
    $scope.deleteUser = function() {
      var ref, sync;
      console.log($scope.name);
      ref = new Firebase(firebaseURL + "organizations/sra/users/");
      sync = $firebase(ref).$asArray();
      sync.$loaded().then(function(data) {
        var i, item, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = data.length; _i < _ref; i = _i += 1) {
          console.log(data[i].$id);
          if (data[i].$id === $scope.name) {
            item = data[i];
            _results.push(sync.$remove(item).then(function(ref) {
              $location.path("/admin/users");
            }));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      });
    };
  });

  window.app.controller("AreasUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, firebaseURL) {});

  window.app.controller("NewUsersController", function($scope, $location, $firebase, $routeParams, $rootScope, $firebaseAuth, firebaseURL) {
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

  window.app.controller("AdminHouseholdsController", function($scope, $rootScope, currentUser, Household) {
    $rootScope.title = "Households Index";
    currentUser.requireLogin();
    orgBuilder.getHouseholdsFromOrg();
  });

  window.app.controller("AdminSecurityController", function($scope, $rootScope, $location, $firebase, $routeParams, firebaseURL, orgBuilder, currentUser) {
    var permishSync, permishref, rolesref, rolessync;
    rolesref = new Firebase(firebaseURL + "organizations/sra/roles");
    rolessync = $firebase(rolesref).$asArray();
    rolessync.$loaded().then(function(data) {
      $scope.roles = data;
    });
    console.log($routeParams.title);
    $scope.roleName = $routeParams.title;
    $scope.role_permissions = [];
    permishref = new Firebase(firebaseURL + "/permissions");
    permishSync = $firebase(permishref).$asArray();
    permishSync.$loaded().then(function(permissions) {
      return $scope.permissions = permissions;
    });
    $scope.addRole = function(title) {
      console.log(title);
      $location.path("/admin/roles/new/permissions/" + title);
    };
    $scope.createRole = function(permissions) {
      console.log(permissions);
      return console.log($scope.roleName);
    };
  });

}).call(this);
