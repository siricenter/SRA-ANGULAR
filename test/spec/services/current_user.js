'use strict';

describe( 'Service: currentUser', function() {
	var subject, setup, $rootScope;

	beforeEach( module( 'sraAngularApp' ) );

	setup = function( currentUser, _$rootScope_ ) {
		subject = currentUser;
		$rootScope = _$rootScope_;
	};

	beforeEach(inject(setup));

	describe( 'currentUser', function() {
		it( 'has a currentUser method', function() {
			expect(subject).toBeDefined();
			expect(subject.currentUser).toBeDefined();
		});

		it( 'returns null if there is no current user', function() {
			$rootScope.currentUser = undefined;
			//spyOn( sessionStorage, 'getItem' ).and.returnValue(undefined);
			expect( subject.currentUser() ).not.toBeDefined();
		});

		it( 'returns the currentUser from session storage if not in rootScope', function() {
			$rootScope.currentUser = undefined;
			spyOn( sessionStorage, 'getItem' ).and.returnValue({currentUser: true});

			var result = subject.currentUser();

			expect( result ).toBeDefined();
			expect( result ).toEqual( { currentUser: true } );
		});

		it( 'returns the currentUser from the rootScope if available', function() {
			$rootScope.currentUser = {currentUser: true};
			spyOn( sessionStorage, 'getItem' ).and.returnValue(undefined);
			var result = subject.currentUser();

			expect( result ).toBeDefined();
			expect( result ).toEqual( { currentUser: true } );
		});
	});
});
