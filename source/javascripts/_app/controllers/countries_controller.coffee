window.app.controller "NewCountryController", ( $scope, Country, currentUser, $location ) ->
	currentUser.requireLogin().then () ->
		submitFunction = () ->
			countryData =
				name: $scope.country.name
			Country.create( 'sra', countryData ).then ( countryRef ) ->
				newPath = "/countries/#{ countryRef.key() }"
				$location.path( newPath )
		$scope.submit = submitFunction

window.app.controller "CountriesIndexController", ( $scope, Country, currentUser,Region ) ->
	currentUser.requireLogin().then () ->
		Region.all('sra').then (data) ->
			$scope.regions = data
			console.log(data)
		Country.all( 'sra' ).then ( countries ) ->
			$scope.countries = countries
			for country in $scope.countries
				country.regions = []
				for region in $scope.regions
					if region.country == country.name
						country.regions.push(region)

			

				

				
window.app.controller "ShowCountryController", ( $scope, Country, Region, currentUser, $routeParams ) ->
	id = $routeParams.countryId
	currentUser.requireLogin()
		.then () ->
			Country.find( 'sra', id )
		.then ( country ) ->
			$scope.country = country
		.then ( country ) ->
			Region.inCountry( 'sra', country.$id )
		.then ( regions ) ->
			$scope.regions = regions
