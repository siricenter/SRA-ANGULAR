window.app.controller "ResponseSetController", ($scope, $rootScope, $location,$firebase, $routeParams, firebaseURL,currentUser,Household,firebase) ->
	currentUser.requireLogin()
	$scope.id = $routeParams.interview
	$scope.familyName = $routeParams.household
	Household.find('sra',$routeParams.household).then (data)->
		for household in data
			if household != undefined
				$scope.household = household
	
	$scope.responses = {}
	$scope.question = null
	$scope.multiChoice = null
	$scope.singleChoice = null

	ref = "#{firebaseURL}/organizations/sra/question%20sets"
	firebase.queryArray(ref).then (data) ->
		for question in data
			if question.name == $scope.id
				$scope.question = question
				
	ref = "#{firebaseURL}/organizations/sra/question%20sets"
	firebase.queryArray(ref).then (questions) ->
		$scope.surveys = questions
		
				
	$scope.submit = ->
		questionsets = {
			name:$scope.question.name,
			qSetId:$scope.question.qSetId,
			type:$scope.question.type,
			questions:[]

			}

		for key, value of $scope.responses
			for i in $scope.question.questions
				if key == i.name
					data={
						name:i.name,
						multiUse:true,
						dataPoints: []
					}
					questionsets.questions.push(data)
					for k, v of value
						for j in questionsets.questions
							data = {
								label: k,
								type: Object.keys(v)[0]
								answers:[]
							}
							data.answers.push(v[data.type])
							j.dataPoints.push(data)
		console.log(questionsets)
		ref = new Firebase("#{firebaseURL}/organizations/sra/resources/#{$scope.household.$id}")
		ref.child('interviews').child('0').child('dateCreated').set(Date.now())
		ref.child('interviews').child('0').child('questionsets').set(questionsets)

				
						



			
      		

		

	

	



	return






		
