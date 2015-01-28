'use strict';

describe( 'Controller: AreasUsersController', function () {

	// load the controller's module
	beforeEach( function () {
		module( 'sraAngularApp' );
	});

	var subject, scope, setup;

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();
		subject = $controller( 'AreasUserController', {
			'$scope': scope
		});
	};

	// Initialize the controller and a mock scope
	beforeEach(inject(setup));

	it( 'has the load regions function', function () {
		expect( scope ).not.toBeNull();
		expect( scope.submit ).not.toBeUndefined();
		expect( scope.submit ).not.toBeNull();
	});

});
