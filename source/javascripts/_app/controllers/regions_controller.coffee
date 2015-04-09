window.app.controller "RegionsIndexController", ( $scope, Region, currentUser, Area ) ->
	currentUser.requireLogin().then () ->
		Region.all( 'sra' ).then ( regions ) ->
			$scope.regions = regions
			for region in $scope.regions
				region.areas = Area.inRegion(region.name)

	

window.app.controller "NewRegionController", ( $scope, Country, Region, currentUser, $location ) ->
	$scope.region = {}
	currentUser.requireLogin().then () ->
		Country.all( 'sra' ).then ( countries ) ->
			$scope.countries = countries
			$scope.region.country = countries[0]
		
		submitFunction = () ->

			regionData =
				country: $scope.region.country
				name: $scope.region.name

			Region.create( 'sra', regionData ).then ( regionRef ) ->
				newPath = "/regions/#{ regionRef.key()  }"
				$location.path( newPath )

		$scope.submit = submitFunction

window.app.controller "ShowRegionController", ( $scope, Region, Area, currentUser, $routeParams ) ->
	currentUser.requireLogin().then () ->
		Region.find( 'sra', $routeParams[ 'regionId' ] )
			.then ( region ) ->
				$scope.region = region
			.then ( region ) ->
				Area.inRegion( 'sra', region.$id )
			.then ( areas ) ->
				$scope.areas = areas
