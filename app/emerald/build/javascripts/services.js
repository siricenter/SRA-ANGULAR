(function() {
  window.app.service("currentUser", function($rootScope, $location, $firebase, $firebaseAuth, firebaseURL, orgBuilder) {
    this.currentUser = function() {
      var stored;
      stored = sessionStorage.getItem("userId");
      if ($rootScope.currentUser != null) {
        return new Promise(function(resolve, reject) {
          return resolve($rootScope.currentUser);
        });
      } else if (stored != null) {
        return this.getUser(stored);
      } else {
        return new Promise(function(resolve, reject) {
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
      url = "" + firebaseURL + "/users/" + userName;
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

(function() {
  window.app.service("orgBuilder", function($firebase, $rootScope) {
    var flatten;
    this.userCache = function(user) {
      var id;
      $rootScope.currentUser = user;
      id = user.$id;
      sessionStorage.setItem("userId", id);
      return user;
    };
    this.getAreasFromRegion = function(region) {
      var ref, sync;
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + region.country + "/regions/" + region.name + "/areas");
      sync = $firebase(ref).$asArray().then();
      return sync.$loaded().then(function(data) {
        return data;
      });
    };
    this.getRegionsFromCountry = function(country) {
      var ref, sync;
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + country + "/regions");
      sync = $firebase(ref).$asArray();
      return sync.$loaded().then(function(data) {
        return data;
      });
    };
    this.getCountriesFromOrg = function() {
      var countries, ref, sync;
      countries = {};
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries");
      sync = $firebase(ref).$asArray();
      countries.data = sync.$loaded().then(function(data) {
        return data;
      });
      return countries;
    };
    flatten = function(array) {
      return [].concat.apply([], array);
    };
    this.getHouseholdsFromArea = function(area) {
      var household, key;
      return flatten((function() {
        var _ref, _results;
        _ref = area.resources;
        _results = [];
        for (key in _ref) {
          household = _ref[key];
          _results.push(household);
        }
        return _results;
      })());
    };
    this.getHouseholdsFromRegion = function(region) {
      var area, name;
      return flatten((function() {
        var _ref, _results;
        _ref = region.areas;
        _results = [];
        for (name in _ref) {
          area = _ref[name];
          _results.push(this.getHouseholdsFromArea(area));
        }
        return _results;
      }).call(this));
    };
    this.getHouseholdsFromCountry = function(country) {
      var name, region;
      return flatten((function() {
        var _ref, _results;
        _ref = country.regions;
        _results = [];
        for (name in _ref) {
          region = _ref[name];
          _results.push(this.getHouseholdsFromRegion(region));
        }
        return _results;
      }).call(this));
    };
    this.getHouseholdsFromOrg = function($scope) {
      var callback, orgBuilder, ref, sync;
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries");
      sync = $firebase(ref).$asArray();
      orgBuilder = this;
      callback = function(countries) {
        var country, households;
        households = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = countries.length; _i < _len; _i++) {
            country = countries[_i];
            _results.push(orgBuilder.getHouseholdsFromCountry(country));
          }
          return _results;
        })();
        $rootScope.households = flatten(households);
        return console.log($rootScope.households);
      };
      return sync.$loaded().then(callback);
    };
  });

}).call(this);
