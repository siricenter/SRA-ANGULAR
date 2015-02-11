'use strict';

describe( 'Controller: NewUsersController', function () {

	var setup, subject, scope, rootScope, uservar;

	beforeEach( function () {
		module( 'sraAngularApp', function( $provide ) {
			var user = {
				create: function( _user ) {
					uservar = _user;
					return {
						then: function(callback) {
							return;
						}
					};
				}
			};

			$provide.value('User', user);
		});
	});

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();

		rootScope = $rootScope;

		subject = $controller( 'NewUsersController', {
			$scope: scope
		});

		scope.user = {};

		scope.user.fname = "Cody";
		scope.user.lname = "Poll";
		scope.user.email = "fake@fake.com";
		scope.user.password = "supersecurepassword00";
	};

	beforeEach( inject( setup ) );

	it( 'has a createUser function', function() {
		expect( scope.createUser ).not.toBeUndefined();
		expect( scope.createUser ).not.toBeNull();
	});

	it( 'uses the User service to create a user', function() {
		scope.createUser();
		expect( uservar ).toBe(scope.user);
	});

	it( 'sets the title to "Create User"', function() {
		expect( rootScope.title ).toBe('Create User');
	});
});
