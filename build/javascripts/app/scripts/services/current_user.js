(function() {
  window.app.service("currentUser", function($rootScope, $location, $firebase, $firebaseAuth, firebaseURL, orgBuilder, $q) {
    this.requireLogin = function() {
      var currentUser;
      currentUser = this;
      return $q(function(resolve, reject) {
        return currentUser.currentUser().then(function(user) {
          $rootScope.currentUser = user;
          return resolve(user);
        })["catch"](function() {
          return $location.path("/login");
        });
      });
    };
    this.currentUser = function() {
      var stored;
      stored = sessionStorage.getItem("userId");
      if ($rootScope.currentUser != null) {
        return $q(function(resolve, reject) {
          return resolve($rootScope.currentUser);
        });
      } else if (stored != null) {
        return this.getUser(stored);
      } else {
        return $q(function(resolve, reject) {
          return reject(Error("No current user"));
        });
      }
    };
    this.authenticate = function(email, password) {
      var authObj, authed, ref;
      authed = this.authed(email);
      ref = new Firebase(firebaseURL);
      authObj = $firebaseAuth(ref);
      return authObj.$authWithPassword({
        email: email,
        password: password
      }).then(authed)["catch"](function(error) {
        console.error("Authentication Failed:", error);
      });
    };
    this.getUser = function(userName) {
      var ref, url, userObj;
      url = "" + firebaseURL + "users/" + userName;
      ref = new Firebase(url);
      userObj = $firebase(ref).$asObject();
      return userObj.$loaded().then(function(user) {
        return $rootScope.currentUser = user;
      });
    };
    this.authed = function(email) {
      var currentUser, getUser, loginRedirect;
      currentUser = this;
      getUser = this.getUser;
      loginRedirect = this.loginRedirect;
      return function() {
        var userName;
        userName = email.split("@").shift();
        return getUser(userName).then(function(userData) {
          orgBuilder.userCache(userData);
          return currentUser.currentUser().then(loginRedirect);
        });
      };
    };
    this.loginRedirect = function(user) {
      var error;
      try {
        if (user.organizations.sra.roles.name === "admin") {
          $location.path("/admin/dashboard");
        } else {
          $location.path("/dashboard");
        }
      } catch (_error) {
        error = _error;
        console.log("Error thrown");
        throw error;
      }
    };
  });

}).call(this);
