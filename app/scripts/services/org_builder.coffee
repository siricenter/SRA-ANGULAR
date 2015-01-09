window.app.service "orgBuilder", ($firebase, $rootScope) ->
	this.orgCache = (ref) ->
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

	this.userCache = (obj) ->
		user = undefined
		storedUser = undefined
		user = {}
		user.email = obj.Email
		user.firstName = obj["First Name"]
		user.lastName = obj["Last Name"]
		user.organizations = obj.Organizations.SRA
		sessionStorage.setItem "user", JSON.stringify(user)
		storedUser = sessionStorage.getItem("user")
		$rootScope.currentUser = {}
		$rootScope.currentUser = JSON.parse(storedUser)

	this.getAreasFromRegion = (region) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + region.Country + "/Regions/" + region.Name + "/Areas")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data

	this.getRegionsFromCountry = (country) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + country + "/Regions")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then (data) ->
			data

	this.getCountriesFromOrg = ->
		countries = {}
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries")
		sync = $firebase(ref).$asArray()
		countries.data = sync.$loaded().then((data) ->
			data
		)
		countries

	this.getHouseholdsFromArea = (area) ->
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + area.Country + "/Regions/" + area.Region + "/Areas/" + area.Name + "/Resources")
		sync = $firebase(ref).$asArray()
		sync.$loaded().then ->

	this.getHouseholdsFromOrg = ->
		householdsCallback = undefined
		areasCallback = undefined
		regionsCallback = undefined
		countriesCallback = undefined
		ref = undefined
		sync = undefined
		ref = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries")
		sync = $firebase(ref).$asArray()
		householdsCallback = (households) ->
			households

		areasCallback = (areas) ->
			k = 0

			while k < areas.length
				houseRef = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + areas[k].Country + "/Regions/" + areas[k].Region + "/Areas/" + areas[k].Name + "/Resources")
				houseSync = $firebase(houseRef).$asArray()
				houseSync.$loaded().then householdsCallback
				k++

		regionsCallback = (regions) ->
			j = 0

			while j < regions.length
				areaRef = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + regions[j].Country + "/Regions/" + regions[j].Name + "/Areas")
				areaSync = $firebase(areaRef).$asArray()
				areaSync.$loaded().then areasCallback
				j++

		countriesCallback = (countries) ->
			i = 0

			while i < countries.length
				regRef = new Firebase("https://intense-inferno-7741.firebaseio.com/Organizations/SRA/Countries/" + countries[i].Name + "/Regions")
				regSync = $firebase(regRef).$asArray()
				regSync.$loaded().then regionsCallback
				i++

		sync.$loaded().then countriesCallback
	return 	# If this return isn't here, then this entire function is evaluated 
			# as just countriesCallback.
