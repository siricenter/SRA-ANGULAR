window.app.service "Region", ( firebaseURL, firebase ) ->
		@inCountry = ( orgId, countryId ) ->
			url = "#{firebaseURL}/organizations/#{orgId}/regions/"
			onLoadPromise = firebase.searchByChild( url, 'country', countryId )
			onLoadPromise
		return
