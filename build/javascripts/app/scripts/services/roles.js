(function() {
  window.app.service("Role", function($firebase, firebaseURL) {
    this.all = function() {
      var rolesref, rolessync;
      rolesref = new Firebase(firebaseURL + "organizations/sra/roles");
      rolessync = $firebase(rolesref).$asArray();
      return rolessync.$loaded();
    };
    this.find = function(id) {
      var ref, role, url;
      url = "" + firebaseURL + "organizations/sra/" + id;
      ref = new Firebase(url);
      role = $firebase(ref).$asObject();
      return role.$loaded();
    };
  });

}).call(this);
