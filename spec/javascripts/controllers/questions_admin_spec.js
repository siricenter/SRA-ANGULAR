'use strict';

describe( 'Controller: QuestionsAdminController', function () {

	var setup, subject, scope, rootScope;

	beforeEach( function () {
		module( 'sraAngularApp', function( $provide ) {
			

			
		});
	});

	setup = function ( $controller, $rootScope ) {
		scope = $rootScope.$new();

		rootScope = $rootScope;

		subject = $controller( 'QuestionsAdminController', {
			'$scope': scope,
		});

		scope.questionSet = {};

		scope.questionSet.name = "Hydration";
		scope.questionSet.questions = [];
		scope.questionSet.type = "HOUSEHOLD";
		
	};

	beforeEach( inject( setup ) );

	it( 'has a createQuestionSet function', function() {
		expect(scope.questionSet.name).not.toBeUndefined();
		expect(scope.questionSet.type).not.toBeUndefined();
		
	});

	
});