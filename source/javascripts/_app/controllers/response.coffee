window.app.controller "ResponseSetController", ($scope, $rootScope, $location,$firebase, $routeParams, firebaseURL,currentUser,Household) ->
	currentUser.requireLogin()
	id = $routeParams.interview
	Household.find('sra',$routeParams.household).then (data)->
		for household in data
			if household != undefined
				$scope.household = household
	
	$scope.responses = {}
	$scope.question = null
	$scope.multiChoice = null
	$scope.singleChoice = null
	$firebase(new Firebase("#{firebaseURL}/organizations/sra/question%20sets")).$asArray().$loaded().then (data) ->
		for question in data
			if question.name == id
				$scope.question = question
				
	$scope.submit = ->
		console.log($scope.responses)
		for answer in $scope.responses
      		for question in answer.questions
      			delete question['$$hashKey']
      			console.log($scope.responses)

      		
		survey = $scope.question
		surveyTitle = survey.name
		qsetId = survey.qsetId
		questions = survey.questions
		responseSet = {
			
			answers:$scope.responses 
		}

		ref = new Firebase("#{firebaseURL}/organizations/sra/resources/#{$scope.household.$id}")
		ref.child('responseSets').set(responseSet)


				
	

			




	return






		
