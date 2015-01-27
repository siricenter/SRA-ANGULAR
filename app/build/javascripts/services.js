(function() {
  window.app.service("orgBuilder", function($firebase, $rootScope) {
    var flatten;
    this.orgCache = function(ref) {
      var fireRef, org;
      fireRef = new Firebase(ref + "organizations/sra");
      org = $firebase(fireRef).$asObject();
      return org.$loaded().then(function(data) {
        var sra;
        sra = {};
        sra.id = data.$id;
        sra.Countries = [];
        sra.Countries = data.countries;
        sra["Question Sets"] = data["Question Sets"];
        sra.Roles = data.roles;
        sra.Users = data.users;
        return localStorage.setItem("SRA", JSON.stringify(sra));
      });
    };
    this.userCache = function(obj) {
      var storedUser, user;
      user = void 0;
      storedUser = void 0;
      user = {};
      user.email = obj.email;
      user.firstName = obj["first name"];
      user.lastName = obj["last name"];
      user.organizations = obj.organizations.sra;
      sessionStorage.setItem("user", JSON.stringify(user));
      storedUser = sessionStorage.getItem("user");
      $rootScope.currentUser = {};
      $rootScope.currentUser = JSON.parse(storedUser);
    };
    this.getAreasFromRegion = function(region) {
      var ref, sync;
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + region.country + "/regions/" + region.name + "/Areas");
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
