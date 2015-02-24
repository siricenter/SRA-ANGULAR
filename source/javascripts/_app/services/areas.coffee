window.app.service "Area", ( firebaseURL, firebase ) ->
	@inRegion = ( orgId, regionId ) ->
		url = "#{firebaseURL}/organizations/#{orgId}/areas/"
		onLoadPromise = firebase.searchByChild( url, 'region', regionId )
		onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise

	@create = ( orgId, areaData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas"
		firebase.create( url, regionData )

	return
