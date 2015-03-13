window.app.controller "ResponseSetController", ($scope, $rootScope, $location,$firebase, $routeParams, firebaseURL,currentUser) ->
	currentUser.requireLogin()
	id = $routeParams.interview
	console.log(id)
	$scope.question = null
	$scope.multiChoice = null
	$scope.singleChoice = null
	$firebase(new Firebase("#{firebaseURL}/organizations/sra/question%20sets")).$asArray().$loaded().then (data) ->
		for question in data
			if question.name == id
				$scope.question = question
				
	

			




	return






		
