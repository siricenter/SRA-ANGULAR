'use strict';

describe('Controller: regionsIndexCtrl', function () {

  // load the controller's module
  beforeEach(module('sraAngularApp'));

  var RegionsIndexCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    RegionsIndexCtrl = $controller('regionsIndexCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.regions.length).toBeGreaterThan(0);
  });
});
