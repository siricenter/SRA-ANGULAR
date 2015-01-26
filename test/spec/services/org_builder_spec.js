'use strict';

describe( 'Service: orgBuilder', function () {
	var subject, setup;

	beforeEach( module( 'sraAngularApp' ) );

	setup = function ( orgBuilder ) {
		subject = orgBuilder;
	};

	beforeEach(inject(setup));

	describe( 'userCache', function() {
		it( 'has a userCache method', function() {
			expect(subject.userCache).not.toBeNull();
			expect(subject.userCache).toBeDefined();
		});

		it( 'puts the user into local storage', function() {
			var user, result;

			user = {
				'First Name': 'Cody',
				'Last Name': 'Poll'
			};

			result = subject.userCache(user);

			expect(result).toBeDefined();
			expect(result).toEqual({
				'First Name': 'Cody',
				'Last Name': 'Poll'
			});
		});
	});
});
