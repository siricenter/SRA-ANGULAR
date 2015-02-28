window.app.service "Role", ($firebase, firebaseURL) ->
	@all = () ->
		rolesref = new Firebase("#{firebaseURL}/organizations/sra/roles")
		rolessync = $firebase(rolesref).$asArray()
		rolessync.$loaded()
	
	@find = (id) ->
		url = "#{firebaseURL}/organizations/sra/roles/#{id}"
		ref = new Firebase(url)
		role = $firebase(ref).$asObject()
		role.$loaded()
	@getPermissions = (role) ->
		permissionsRef = $firebase(new Firebase("#{firebaseURL}/organizations/sra/roles/#{role}/permissions")).$asArray().$loaded()
	return
