'use strict';

describe( 'Controller: LoginController', function () {

	var setup, subject, scope, email, password;

	// load the controller's module
	beforeEach( function () {
		module( 'sraAngularApp', function($provide) {
			// Creating a mock object to replace the currentUser service in our
			// tests.
			var currentUser = {
				authenticate: function ( _email, _password ) {
					// email and passwords are defined on line 5.
					// This basically lets us see what the LoginController
					// passes to the currentUser service.
					email = _email;
					password = _password;
				},
				currentUser: function(user) {
					return {
						then: function(callback) {
							return {
								catch: function() {
									return;
								}
							}
						}
					}
				}
			};

			// Whenever the currentUser is a dependency in these tests, inject the
			// currentUser object we defined above instead of the real service.
			$provide.value('currentUser', currentUser);
		});
	});

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();

		// Apparently, this doesn't just create the controller - it runs it too,
		// with the given scope. This means that in our tests, we can just test
		// that the scope was changed appropriately.
		subject = $controller( 'LoginController', {
			'$scope': scope
		});
	};

	// Initialize the controller and a mock scope
	beforeEach( inject( setup ) );

	it( 'has the login function', function () {
		// After the controller executes, its scope should have a function
		// called submit.
		expect( scope.submit ).not.toBeUndefined();
		expect( scope.submit ).not.toBeNull();
	});

	it( 'collects the email and password and sends it for auth' , function () {
		// After the controller executes, its scope should have a function
		// called submit. Here, we test that the submit function gives the email
		// and password to the currentUser service.
		
		// Setup the scope to reflect having a form submitted.
		scope.user = {};
		scope.user.email = "fake@email.com";
		scope.user.password = "mypass";

		// Call the login (submit) function
		scope.submit();
		
		expect(email).toBe(scope.user.email);
		expect(password).toBe(scope.user.password);
	});

});
