window.app.service "Household", ( firebase, firebaseURL, orgBuilder ) ->
	@all = ( org ) ->
		orgBuilder.getHouseholdsFromOrg( org )
	
	@find = ( id ) ->
		url = "#{ firebaseURL }/users/#{ id }"
		firebase.queryObject( url )
	
	return
