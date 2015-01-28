'use strict';

describe( 'Controller: DeleteUsersController', function () {

	// load the controller's module
	beforeEach( function () {
		module( 'sraAngularApp' );
	});

	var subject, scope, setup;

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();
		subject = $controller( 'DeleteUserController', {
			'$scope': scope
		});
	};

	// Initialize the controller and a mock scope
	beforeEach(inject(setup));

	it( 'it has a user in the routeParams', function () {
		expect( scope ).not.toBeNull();
		expect( scope.submit ).not.toBeUndefined();
		expect( scope.submit ).not.toBeNull();
	});

});
