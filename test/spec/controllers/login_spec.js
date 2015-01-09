'use strict';

describe( 'Controller: LoginController', function () {

	// load the controller's module
	beforeEach( function () {
		module( 'sraAngularApp' );
	});

	var subject, scope, setup;

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();
		subject = $controller( 'LoginController', {
			$scope: scope
		});
	};

	// Initialize the controller and a mock scope
	beforeEach( 
			inject( setup ));

	it( 'has the login function', function () {
		expect( scope ).not.toBeNull();
		expect( scope.Login ).not.toBeUndefined();
		expect( scope.Login ).not.toBeNull();
		expect( typeof scope.Login ).toBe('function');
	});

});
