window.app.controller "NutritionController", ($scope, $location, $firebase, $routeParams, firebaseURL, currentUser,$http) ->
  currentUser.requireLogin().then () ->
    household = $firebase(new Firebase("#{firebaseURL}/organizations/sra/resources")).$asArray().$loaded()
    $scope.name = $routeParams.household
    household.then (households) ->
      for household in households
        if $scope.name == household.name
          $scope.household = household
    $scope.finish = ->
    
      for answer in $scope.responseSet
        delete answer['$$hashKey']
      ref = new Firebase("#{firebaseURL}/organizations/sra/resources/#{$scope.household.$id}")
      ref.child('nutrition').set($scope.responseSet)
        

    $scope.responseSet = []

    $scope.calTotal = 0
    $scope.proteinTotal = 0
    $scope.sodiumTotal = 0
    $scope.carbTotal = 0

    $scope.servings = {
      amount:1
      frequency:null
    }
    $scope.selectedValue

    class FoodItem
          constructor: (calories,sodium,protein,carbs,name,brand,frequency,servings,cal_from_fat,total_fat,sat_fat,water_grams,trans_fat,cholest,sugar,vitamin_a,vitamin_c,calcium,iron) ->
            @itemName = name
            @brandName = brand
            @nfCalories = calories
            @nfCaloriesFromFat = cal_from_fat
            @nfTotalFat = total_fat
            @nfSaturatedFat = sat_fat
            @nfWaterGrams = water_grams
            @nfTransFattyAcid = trans_fat
            @nfCholesterol = cholest
            @nfSugars = sugar
            @nfVitaminADv = vitamin_a
            @nfVitaminCDv = vitamin_c
            @nfCalciumDv = calcium
            @nfIronDv = iron
            @nfSodium = sodium
            @nfProtein = protein
            @nfTotalCarbohydrate = carbs
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
        limit:3,
        data:{"appId":"f67bfd42","appKey":"c69bd76b98dd8d4e1fd629241b3bb199","query":food},
      }
    
      $http(req).success((data, status, headers, config) ->
        $scope.foods=data.hits).error (data, status, headers, config) -> 
          console.log(data)

      $scope.addFood = (item_id) ->
        url = "https://api.nutritionix.com/v1_1/item?id=#{item_id}&appId=f67bfd42&appKey=c69bd76b98dd8d4e1fd629241b3bb199"
        $http.get(url).success (data,status, headers, config) ->
          amt = $scope.servings.amount
          console.log(data)
          id = data.item_id
          calories = data.nf_calories * amt
          carbs = data.nf_total_carbohydrate * amt
          sodium = data.nf_sodium * amt
          name = data.item_name
          cal_from_fat = data.nf_calories_from_fat
          total_fat = data.nf_total_fat
          sat_fat = data.nf_saturated_fat
          water_grams = data.nf_water_grams
          trans_fat = data.nf_trans_fatty_acid
          cholest = data.nf_cholesterol
          sugar = data.nf_sugars
          vitamin_a = data.nf_vitamin_a_dv
          vitamin_c = data.nf_vitamin_c_dv
          calcium = data.nf_calcium_dv
          iron = data.nf_iron_dv
          sodium = data.nf_sodium
          protein = data.nf_protein * amt
          brand = data.brand_name
          servings = amt
          frequency = $scope.servings.frequency * amt
          foodObject = new FoodItem(calories,sodium,protein,carbs,name,brand,frequency,servings,cal_from_fat,total_fat,sat_fat,water_grams,trans_fat,cholest,sugar,vitamin_a,vitamin_c,calcium,iron)
          console.log(foodObject)
          $scope.responseSet.push(foodObject)
          calc(foodObject)

      calc = (item)->       
        $scope.calTotal += item.nfCalories
        $scope.sodiumTotal += item.nfSodium
        $scope.carbTotal += item.nfTotalCarbohydrate
        $scope.proteinTotal += item.nfProtein
        return
      
        
 
    return
