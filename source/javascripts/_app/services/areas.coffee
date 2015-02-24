window.app.service "Area", ( firebaseURL, firebase ) ->
	@inRegion = ( orgId, regionId ) ->
		url = "#{firebaseURL}/organizations/#{orgId}/areas/"
		onLoadPromise = firebase.searchByChild( url, 'region', regionId )
		onLoadPromise

	@find = ( orgId, areaId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas/#{ areaId }"
		onLoadPromise = firebase.queryObject( url )
		return onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas"
		onLoadPromise = firebase.queryArray( url )
		return onLoadPromise

	@create = ( orgId, areaData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas"
		firebase.create( url, areaData )

	return
