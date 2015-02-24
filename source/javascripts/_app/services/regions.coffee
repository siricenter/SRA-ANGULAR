window.app.service "Region", ( firebaseURL, firebase ) ->

	@inCountry = ( orgId, countryId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/regions/"
		onLoadPromise = firebase.searchByChild( url, 'country', countryId )
		onLoadPromise
	
	@find = ( orgId, regionId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/regions/#{ regionId }"
		onLoadPromise = firebase.queryObject( url )
		onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/regions"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise

	@create = ( orgId, regionData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/regions"
		firebase.create( url, regionData )

	return
