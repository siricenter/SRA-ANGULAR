window.app.service "Household", ( firebase, firebaseURL, orgBuilder ) ->
	@inArea = ( orgId, areaId ) ->
		url = "#{firebaseURL}/organizations/#{orgId}/resources/"
		onLoadPromise = firebase.searchByChild( url, "area", areaId )
		onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise
	
	@find = ( orgId, householdId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/#{ householdId }"
		firebase.queryObject( url )
	
	return
