window.app.service "orgBuilder", ($firebase, $rootScope) ->
	@orgCache = (ref) ->
		fireRef = new Firebase(ref + "Organizations/SRA")
		org = $firebase(fireRef).$asObject()
		org.$loaded().then (data) ->
			sra = {}
			sra.id = data.$id
			sra.Countries = []
			sra.Countries = data.Countries
			sra["Question Sets"] = data["Question Sets"]
			sra.Roles = data.Roles
			sra.Users = data.Users
			localStorage.setItem "SRA", JSON.stringify(sra)

	@userCache = (obj) ->
		user = {}
		user.email = obj.Email
		user.firstName = obj["First Name"]
		user.lastName = obj["Last Name"]
		user.organizations = obj.Organizations.SRA
		sessionStorage.setItem "user", JSON.stringify(user)
		storedUser = sessionStorage.getItem("user")
		$rootScope.currentUser = {}
		$rootScope.currentUser = JSON.parse(storedUser)

	@getAreasFromRegion = (region) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + region.Country + "/Regions/" + region.Name + "/Areas")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data

	@getRegionsFromCountry = (country) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + country + "/Regions")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data

	@getCountriesFromOrg = ->
		countries = {}
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries")
		sync = $firebase(ref).$asArray()
		countries.data = sync.$loaded().then((data) ->
			data
		)
		countries
	
	flatten = (array) ->
		return [].concat.apply([], array) # flatten array

	@getHouseholdsFromArea = (area) ->
		flatten(for household of area.Resources
			household)

	@getHouseholdsFromRegion = (region) ->
		flatten(for name, area of region.Areas
			@getHouseholdsFromArea(area))

	@getHouseholdsFromCountry = (country) ->
		flatten(for name, region of country.Regions
			@getHouseholdsFromRegion(region))

	@getHouseholdsFromOrg = ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries")
		sync = $firebase(ref).$asArray()
		orgBuilder = this

		callback = (countries) ->
			households = (orgBuilder.getHouseholdsFromCountry(country) for country in countries)

			return flatten households
			

		sync.$loaded().then callback
	return 	# If @return isn't here, then @entire function is evaluated 
			# as just countriesCallback.
