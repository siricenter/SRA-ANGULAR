'use strict';

describe( 'Controller: QuestionsAdminController', function () {

	 var setup, subject, scope, email, password;

	

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();

		// Apparently, this doesn't just create the controller - it runs it too,
		// with the given scope. This means that in our tests, we can just test
		// that the scope was changed appropriately.
		subject = $controller( 'NutritionController', {
			'$scope': scope
		});
	};

	// Initialize the controller and a mock scope
	beforeEach( inject( setup ) );

	it( 'has the buildSurvey function', function () {
		// After the controller executes, its scope should have a function
		// called submit.
		expect( scope.buildSurvey ).not.toBeUndefined();
		expect( scope.buildSurvey ).not.toBeNull();
	});
	it( 'has the search function', function () {
		// After the controller executes, its scope should have a function
		// called submit.
		expect( scope.search ).not.toBeUndefined();
		expect( scope.search ).not.toBeNull();
	});


	it( 'collects the datapoint for the interview' , function () {
		// After the controller executes, its scope should have a function
		// called submit. Here, we test that the submit function gives the email
		// and password to the currentUser service.
		
		// Setup the scope to reflect having a form submitted.
		query = "pizza"

		// Call the login (submit) function
		scope.buildSurvey(query);
		
		expect($scope.foods).not.toBeNull();
		
	});


	
});
