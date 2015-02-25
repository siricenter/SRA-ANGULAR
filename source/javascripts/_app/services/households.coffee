window.app.service "Household", ( firebase, firebaseURL, orgBuilder ) ->
	@inArea = ( orgId, areaId ) ->
		url = "#{firebaseURL}/organizations/#{orgId}/resources/"
		onLoadPromise = firebase.searchByChild( url, "area", areaId )
		onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise

	@create = ( orgId, householdData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		firebase.create( url, householdData )
	
	@find = ( orgId, householdId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources/#{ householdId }"
		firebase.queryObject( url )
	
	return
