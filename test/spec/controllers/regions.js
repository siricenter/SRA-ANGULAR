'use strict';

describe('Controller: regionsIndexCtrl', function () {

  // load the controller's module
  beforeEach(module('sraAngularApp'));

  var regionsIndexCtrl,

    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    regionsIndexCtrl = $controller('regionsIndexCtrl', {
    $scope: scope
    });
  }));

  it('regions should have an array of regions', function () {
    expect(scope.regions.length).toBeGreaterThan(0);
  });
});
