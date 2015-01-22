window.app.service "orgBuilder", ($firebase, $rootScope) ->
	@userCache = (user) ->
		$rootScope.currentUser = user
		sessionStorage.setItem "userId", JSON.stringify(user.$id)

		return user

	@getAreasFromRegion = (region) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + region.country + "/regions/" + region.name + "/Areas")
		sync = $firebase(ref).$asArray().then()
		sync.$loaded().then (data) ->
			data

	@getRegionsFromCountry = (country) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + country + "/regions")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data

	@getCountriesFromOrg = ->
		countries = {}
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries")
		sync = $firebase(ref).$asArray()
		countries.data = sync.$loaded().then((data) ->
			data
		)
		countries
	
	flatten = (array) ->
		return [].concat.apply([], array) # flatten array

	@getHouseholdsFromArea = (area) ->
		flatten(for key, household of area.resources
			household)

	@getHouseholdsFromRegion = (region) ->
		flatten(for name, area of region.areas
			@getHouseholdsFromArea(area))

	@getHouseholdsFromCountry = (country) ->
		flatten(for name, region of country.regions
			@getHouseholdsFromRegion(region))

	@getHouseholdsFromOrg = ($scope) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries")
		sync = $firebase(ref).$asArray()
		orgBuilder = this

		callback = (countries) ->
			households = (orgBuilder.getHouseholdsFromCountry(country) for country in countries)

			$rootScope.households = flatten households
			console.log($rootScope.households)
			
		sync.$loaded().then callback
		# If @return isn't here, then @entire function is evaluated 
			# as just countriesCallback.
	

	return 
