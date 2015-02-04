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
      return country.regions;
    };
    this.getCountriesFromOrg = function() {
      var countries, ref;
      countries = {};
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries");
      return $firebase(ref).$asArray().$loaded();
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
    this.getHouseholdsFromOrg = function(org) {
      var orgBuilder, ref, sync;
      ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/" + org + "/countries");
      sync = $firebase(ref).$asArray();
      orgBuilder = this;
      return sync.$loaded().then(function(countries) {
        var country;
        return flatten((function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = countries.length; _i < _len; _i++) {
            country = countries[_i];
            _results.push(orgBuilder.getHouseholdsFromCountry(country));
          }
          return _results;
        })());
      });
    };
  });

}).call(this);
