window.app.service "orgBuilder", ($firebase, $rootScope) ->
	@userCache = (user) ->
		$rootScope.currentUser = user
		id = user.$id
		sessionStorage.setItem "userId", id

		return user

	@getAreasFromRegion = (region) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + region.country + "/regions/" + region.name + "/areas")
		sync = $firebase(ref).$asArray().then()
		sync.$loaded().then (data) ->
			data

	@getRegionsFromCountry = (country) ->
		country.regions
		#ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries/" + country + "/regions")
		#sync = $firebase(ref).$asArray()
		#sync.$loaded().then (data) ->
		#	data

	@getCountriesFromOrg = ->
		countries = {}
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/sra/countries")
		$firebase(ref).$asArray().$loaded()
	
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

	@getHouseholdsFromOrg = (org) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/organizations/#{org}/countries")
		sync = $firebase(ref).$asArray()
		orgBuilder = this

		sync.$loaded().then (countries) ->
			flatten (orgBuilder.getHouseholdsFromCountry(country) for country in countries)

	return
