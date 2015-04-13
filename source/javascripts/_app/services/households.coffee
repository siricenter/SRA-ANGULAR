window.app.service "Household", ( firebase, firebaseURL ) ->
	@inArea = ( orgId, areaName ) ->
		householdsInArea = []
		url = "#{firebaseURL}/organizations/#{orgId}/resources/"
		onLoadPromise = firebase.queryArray(url)
		onLoadPromise.then (households) ->
			for household in households
				if areaName == household.area
					householdsInArea.push household
					console.log(household)
		return householdsInArea
	@all = (orgId) ->
		url = "#{firebaseURL}/organizations/#{orgId}/resources/"
		onLoadPromise = firebase.queryArray(url)
		onLoadPromise


		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		onLoadPromise = firebase.queryArray(url)
		return onLoadPromise

	@create = ( orgId, householdData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		firebase.create( url, householdData )
	
	@find = ( orgId, householdName ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/resources"
		firebase.queryArray( url ).then (households)->
			for household in households 
				if household.name == householdName
					result = household
		
		

	
	return
