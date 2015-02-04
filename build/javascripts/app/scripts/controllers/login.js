(function() {
  window.app.controller("LoginController", function($scope, $location, $rootScope, currentUser) {
    var loginFunction;
    $rootScope.title = "Login";
    loginFunction = function() {
      var email, password;
      email = $scope.user.email;
      password = $scope.user.password;
      return currentUser.authenticate(email, password);
    };
    $scope.submit = loginFunction;
  });

  window.app.controller("DashboardController", function($scope, $location, $rootScope, currentUser) {
    var user;
    $rootScope.title = "Dashboard";
    user = currentUser.currentUser();
    $scope.user = user;
    $scope.areas = user.areas;
    $scope.firstname = user.firstName;
    $scope.lastName = user.lastName;
    if (user.roles === "Admin") {
      $location.path("/admin/dashboard");
    }
  });

}).call(this);
