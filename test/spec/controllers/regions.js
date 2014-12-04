'use strict';

describe('Controller: regionsIndexCtrl', function () {

  // load the controller's module
  beforeEach(module('sraAngularApp'));

<<<<<<< HEAD
  var regionsIndexCtrl,
=======
  var RegionsIndexCtrl,
>>>>>>> 4b0ec21bdb02804c93a29a580b5306fc0a650b4c
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
<<<<<<< HEAD
    regionsIndexCtrl = $controller('regionsIndexCtrl', {
    $scope: scope
    });
  }));

  it('regions should have an array of regions', function () {
    expect($scope.regions.length).toBeGreaterThan(0);
=======
    RegionsIndexCtrl = $controller('regionsIndexCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.regions.length).toBeGreaterThan(0);
>>>>>>> 4b0ec21bdb02804c93a29a580b5306fc0a650b4c
  });
});
