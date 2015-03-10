window.app.controller "NutritionController", ($scope, $location, firebase, $routeParams, firebaseURL, currentUser,$http) ->
	$scope.responseSet = []

	$scope.calTotal = 0
	$scope.proteinTotal = 0
	$scope.sodiumTotal = 0
	$scope.carbTotal = 0


	$scope.name = $routeParams.household

	$scope.servings = {
		amount:1
		frequency:null
	}
	$scope.selectedValue

	class FoodItem
  			constructor: (calories,sodium,protein,carbs,name,brand,frequency,servings) ->
  				@name = name
  				@brand = brand
  				@calories = calories
  				@sodium = sodium
  				@protein = protein
  				@carbs = carbs
  				@frequency = frequency
  				@servings = servings

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
    	 $http.get(url).success (data,status, headers, config) ->
    	 	amt = $scope.servings.amount
    	 	console.log(amt)
    	 	calories = data.nf_calories * amt
    	 	carbs = data.nf_total_carbohydrate * amt
    	 	sodium = data.nf_sodium *amt
    	 	name = data.item_name
    	 	protein = data.nf_protein * amt
    	 	brand = data.brand_name
    	 	servings = amt
    	 	frequency = $scope.servings.frequency * amt
    	 	foodObject = new FoodItem(calories,sodium,protein,carbs,name,brand,frequency,servings)
    	 	console.log(foodObject)
    	 	$scope.responseSet.push(foodObject)
    	
    	 	calc()

    calc = ->	 	
    	for item in $scope.responseSet
    		$scope.calTotal += item.calories
    		$scope.sodiumTotal += item.sodium
    		$scope.carbTotal += item.carbs
    		$scope.proteinTotal += item.protein


    	 	
	return
