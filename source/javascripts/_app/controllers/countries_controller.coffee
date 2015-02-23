window.app.controller "NewCountryController", ( $scope, Country, currentUser ) ->
	currentUser.requireLogin().then () ->
		submitFunction = () ->
			countryData =
				name: $scope['new-country-form']['new-country-name']
			Country.create( countryData ).then ( country ) ->
				$location.path = "/countries/#{ country._id }"

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
