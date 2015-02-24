window.app.controller "AreasIndexController", ( $scope, currentUser, Area ) ->
	currentUser.requireLogin().then () ->
		Area.all( "sra" ).then ( areas ) ->
			$scope.areas = areas


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
	currentUser.requireLogin()
		.then () ->
			Region.all( "sra" )
		.then ( regions ) ->
			$scope.regions = regions
		.then ( regions ) ->
			areaSubmitFunction = () ->
				Region.find( "sra", $scope.area.region )
					.then ( region ) ->
						areaData =
							country: region.country
							region: region.$id
							name: $scope.area.name
						Area.create( "sra", areaData )
					.then ( areaRef ) ->
						$location.path("/areas/#{ areaRef.key() }")
			$scope.areaSubmit = areaSubmitFunction
