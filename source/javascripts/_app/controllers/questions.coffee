window.app.controller "QuestionsAdminController", ($scope, $rootScope, $location, $firebase, $routeParams, firebaseURL, currentUser,Question) ->
 	
 	$scope.types = ["Areas","Households"]
  $scope.questionTypes = ["Single Use","Multi-Use"]
  
  $scope.question = []
  $scope.questions = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/question sets")).$asArray()
  $scope.responseTypes = ["Date","Text","Number","Multi-Choice","Single-Choice"]
  $scope.points = []

     
  $scope.buildSurvey = ->
    
    if $scope.survey_type == '1'
      $scope.survey_type = "HOUSEHOLD"
    else if $scope.survey_type == '0'
      $scope.survey_type = "AREA"

    if $scope.quest.type == '4'
      $scope.quest.type = true
    else if $scope.quest.type == '3'
      $scope.quest.type = false
    else if $scope.quest.type == undefined
      $scope.quest.type = false

    dataPointsArray = []

    class DataPoint
        constructor: (label,singleAnswer,type,answers) ->
          @label = label
          @singleAnswer = singleAnswer
          @type = type
          @answers = answers

      for label in $scope.points
        datapoint = new DataPoint
        datapoint.label = label
        for type in $scope.types
          datapoint.type = type
          datapoint.singleAnswer = $scope.quest.type
          datapoint.answers = [""]
          dataPointsArray.push(datapoint)

    questions = {
      name: $scope.questionTitle,
      multiUse:$scope.quest.type,
      dataPoints:dataPointsArray
    }

    questionsArray = []
    questionsArray.push(questions)

    questionSet = {
      name: $scope.surveyTitle,
      type: $scope.survey_type,
      questions: questionsArray
      qSetId: null

    }

    
    console.log(questionSet)
    console.log(questions)
    
   

    ref = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/question%20sets")).$asArray()
    console.log(ref)
    ref.$add(questionSet).then (ref) ->
      id = ref.key()
      console.log(id)
      objref = $firebase(new Firebase("https://testrbdc.firebaseio.com/organizations/sra/question%20sets/#{id}"))
      objref.$set('qSetId', id).then (data) ->
          data.key()
          # foo
          return
      
			






 		
 			

	
	return	