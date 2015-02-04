window.app.service "Role", ($firebase, firebaseURL) ->
	@all = () ->
		rolesref = new Firebase(firebaseURL + "organizations/sra/roles")
		rolessync = $firebase(rolesref).$asArray()
		rolessync.$loaded()
	
	@find = (id) ->
		url = "#{firebaseURL}organizations/sra/#{id}"
		ref = new Firebase(url)
		role = $firebase(ref).$asObject()
		role.$loaded()
	return
