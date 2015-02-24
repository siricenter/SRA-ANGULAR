window.app.controller "RegionsIndexController", ( $scope, Region, currentUser ) ->
	currentUser.requireLogin().then () ->
		Region.all( 'sra' ).then ( regions ) ->
			$scope.regions = regions
	

window.app.controller "NewRegionController", ( $scope, Country, Region, currentUser, $location ) ->
	$scope.region = {}
	currentUser.requireLogin().then () ->
		Country.all( 'sra' ).then ( countries ) ->
			$scope.countries = countries
		
		submitFunction = () ->

			regionData =
				country: $scope.region.country
				name: $scope.region.name

			Region.create( 'sra', regionData ).then ( regionRef ) ->
				newPath = "/regions/#{ regionRef.key()  }"
				$location.path( newPath )

		$scope.submit = submitFunction
