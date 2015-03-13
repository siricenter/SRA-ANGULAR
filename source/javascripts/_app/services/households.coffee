window.app.service "Household", ( firebase, firebaseURL ) ->
	@inArea = ( orgId, areaName ) ->
		url = "#{firebaseURL}/organizations/#{orgId}/resources/"
		onLoadPromise = firebase.searchByChild( url, "area", areaName )
		onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise

	@create = ( orgId, householdData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		firebase.create( url, householdData )
	
	@find = ( orgId, householdId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources/#{ householdId.toLowerCase() }"
		firebase.queryObject( url )
	
	return
