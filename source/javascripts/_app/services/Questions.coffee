window.app.service "Question", ( firebase, firebaseURL ) ->
	@all = () ->
		url = "#{ firebaseURL }/organizations/sra/question%20sets"
		onLoadPromise = firebase.queryArray( url )
		return onLoadPromise

		
	@find = (id) ->
		ref = $firebase(new Firebase("#{firebaseURL}/organizations/sra/question%20sets")).$asArray().$loaded()
		
		


							
