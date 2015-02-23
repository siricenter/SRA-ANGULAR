window.app.controller "NewCountryController", ( $scope, Country, currentUser, $location ) ->
	currentUser.requireLogin().then () ->
		submitFunction = () ->
			countryData =
				name: $scope.country.name
			Country.create( 'sra', countryData ).then ( countryRef ) ->
				newPath = "/countries/#{ countryRef.key() }"
				$location.path( newPath )
		$scope.submit = submitFunction

window.app.controller "CountriesIndexController", ( $scope, Country, currentUser ) ->
	currentUser.requireLogin().then () ->
		Country.all( 'sra' ).then ( countries ) ->
			$scope.countries = countries

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
