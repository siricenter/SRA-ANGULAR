window.app.service "Household", ($firebase, $firebaseAuth, firebaseURL, orgBuilder) ->
	@all = (org) ->
		orgBuilder.getHouseholdsFromOrg(org)
	
	@find = (id) ->
		url = "#{firebaseURL}/users/#{id}"
		ref = new Firebase(url)
		household = $firebase(ref).$asObject()
		household.$loaded()
	return
