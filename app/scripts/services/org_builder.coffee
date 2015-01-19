window.app.service "orgBuilder", ($firebase, $rootScope) ->
	@orgCache = (ref) ->
		fireRef = new Firebase(ref + "organizations/sra")
		org = $firebase(fireRef).$asObject()
		org.$loaded().then (data) ->
			sra = {}
			sra.id = data.$id
			sra.Countries = []
			sra.Countries = data.countries
			sra["Question Sets"] = data["Question Sets"]
			sra.Roles = data.roles
			sra.Users = data.users
			localStorage.setItem "SRA", JSON.stringify(sra)

	@userCache = (obj) ->
		user = undefined
		storedUser = undefined
		user = {}
		user.email = obj.email
		user.firstName = obj["first name"]
		user.lastName = obj["last name"]
		user.organizations = obj.organizations.sra
		sessionStorage.setItem "user", JSON.stringify(user)
		storedUser = sessionStorage.getItem("user")
		$rootScope.currentUser = {}
		$rootScope.currentUser = JSON.parse(storedUser)
		return

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