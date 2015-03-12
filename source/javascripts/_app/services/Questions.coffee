window.app.service "Question", ($firebase, firebaseURL) ->
	@all = () ->
		ref = $firebase(new Firebase("#{firebaseURL}/organizations/sra/question%20sets")).$asArray().$loaded()
		
	@find = (id) ->
		ref = $firebase(new Firebase("#{firebaseURL}/organizations/sra/question%20sets")).$asArray().$loaded()
		
		


							
