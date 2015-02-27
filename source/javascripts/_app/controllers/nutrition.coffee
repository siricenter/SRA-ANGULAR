window.app.controller "NutritionController", ($scope, Nutrionix, $location, firebase, $routeParams, firebaseURL, currentUser,nixApi) ->

  nixApi.autocomplete($scope.food).success (suggestions) ->
    $scope.autocomplete = suggestions
    return

  	nixApi.natural([
    	'1 tbsp sugar'
    	'16 fl oz water'
    	'1/2 lemon'
  	].join('\n')).success (natural) ->
    	$scope.natural = natural
    	return

  	nixApi.search($scope.food).success (search) ->
    	$scope.search = search
    	return
  	nixApi.brand_search('mcdon', [
    	1
    	3
  	]).success (brandSearch) ->
    	$scope.brandSearch = brandSearch
    	return
  	nixApi.item('8GkO3').success (item) ->
    	$scope.item = item
    	return
  	nixApi.item('0kGURkwz').success (item) ->
    	$scope.itemByResource = item
    	return
  	nixApi.brand('B1J9').success (brand) ->
    	$scope.brand = brand
    	return
  	return

	
return