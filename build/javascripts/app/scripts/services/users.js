(function() {
  window.app.service("User", function($firebase, $firebaseAuth, firebaseURL) {
    this.all = function() {
      var ref, users;
      ref = new Firebase("" + firebaseURL + "users");
      users = $firebase(ref).$asArray();
      return users.$loaded();
    };
    this.find = function(id) {
      var ref, url, user;
      url = "" + firebaseURL + "users/" + id;
      ref = new Firebase(url);
      user = $firebase(ref).$asObject();
      return user.$loaded();
    };
  });

}).call(this);
