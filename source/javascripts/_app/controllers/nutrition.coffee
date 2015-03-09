window.app.controller "NutritionController", ($scope, $location, firebase, $routeParams, firebaseURL, currentUser,$http) ->
	$scope.responseSet = []
	$scope.name = $routeParams.household
	$scope.frequency

	
	$scope.search = (food)->
		req = {
 			method: 'POST',
 			url: 'https://api.nutritionix.com/v1_1/search',
 			headers: {
   			'Content-Type': 'application/json'
 			},
 			data:{"appId":"f67bfd42","appKey":"c69bd76b98dd8d4e1fd629241b3bb199","query":food},
		}
		
		$http(req).success((data, status, headers, config) ->
			$scope.foods=data.hits).error (data, status, headers, config) -> 
    			console.log(data)

    $scope.addFood = (item_id) ->
    	 url = "https://api.nutritionix.com/v1_1/item?id=#{item_id}&appId=f67bfd42&appKey=c69bd76b98dd8d4e1fd629241b3bb199"
    	 $http.get(url).success((data,status, headers, config)->
    	 	$scope.responseSet.push(data)).error (data,status,headers,config) ->
    	 		console.log(data)

    	 	
	return
