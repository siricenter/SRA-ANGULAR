window.app.controller "AreasIndexController", ( $scope, currentUser, Area, Household ) ->
	currentUser.requireLogin().then () ->
		Area.all('sra').then (data) ->
			$scope.areas = data
			for area in $scope.areas
				area.households = Household.inArea('sra',area.name)
		console.log($scope.areas)


window.app.controller "ShowAreaController", ( $scope, $routeParams, currentUser, Area, Household ) ->
	currentUser.requireLogin()
		.then () ->
			Area.find( "sra", $routeParams.areaId )
		.then ( area ) ->
			$scope.area = area
		.then ( area ) ->
			Household.inArea( "sra", area.$id )
		.then ( households ) ->
			$scope.households = households


window.app.controller "NewAreaController", ( $scope, currentUser, $location, Area, Region ) ->
	$scope.area = {}
	currentUser.requireLogin()
		.then () ->
			Region.all( "sra" )
		.then ( regions ) ->
			$scope.regions = regions
			$scope.area.region = regions[0]
		.then ( regions ) ->
			areaSubmitFunction = () ->
				region = $scope.area.region
				areaData =
					country: region.country
					region: region.$id
					name: $scope.area.name
				Area.create( "sra", areaData )
					.then ( areaRef ) ->
						$location.path("/areas/#{ areaRef.key() }")
			$scope.submit = areaSubmitFunction
