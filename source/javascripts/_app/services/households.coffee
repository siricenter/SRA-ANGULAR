window.app.service "Household", ( firebase, firebaseURL, orgBuilder ) ->
	@inArea = ( orgId, areaId ) ->
		url = "#{firebaseURL}/organizations/#{orgId}/households/"
		onLoadPromise = firebase.searchByChild( url, "area", areaId )
		onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/households"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise
	
	@find = ( id ) ->
		url = "#{ firebaseURL }/users/#{ id }"
		firebase.queryObject( url )
	
	return
