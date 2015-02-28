window.app.service "Permission", ($firebase, firebaseURL) ->
	@all = () ->
		permishref = $firebase(new Firebase("https://testrbdc.firebaseio.com/permissions")).$asArray().$loaded()
		
	
	@find = (id) ->
		url = "#{firebaseURL}/organizations/sra/#{id}"
		ref = new Firebase(url)
		permissions = $firebase(ref).$asObject()
		permissions.$loaded()
	
	return
