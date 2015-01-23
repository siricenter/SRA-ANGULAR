(function() {
  window.app.service("currentUser", function($rootScope) {
    this.currentUser = function() {
      var stored;
      if ($rootScope.currentUser != null) {
        return $rootScope.currentUser;
      }
      stored = sessionStorage.getItem('userId');
      if (stored != null) {
        return stored;
      }
      return void 0;
    };
  });

}).call(this);

(function() {
  window.app.service("orgBuilder", function($firebase, $rootScope) {
    var flatten;
    this.userCache = function(user) {
      $rootScope.currentUser = user;
      sessionStorage.setItem("userId", JSON.stringify(user.$id));
      return user;
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
