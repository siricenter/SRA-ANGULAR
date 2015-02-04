(function() {
  window.app.service("Household", function($firebase, $firebaseAuth, firebaseURL, orgBuilder) {
    this.all = function(org) {
      return orgBuilder.getHouseholdsFromOrg(org);
    };
    this.find = function(id) {
      var household, ref, url;
      url = "" + firebaseURL + "users/" + id;
      ref = new Firebase(url);
      household = $firebase(ref).$asObject();
      return household.$loaded();
    };
  });

}).call(this);
