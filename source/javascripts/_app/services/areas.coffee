window.app.service "Area", ( firebaseURL, firebase ) ->
	@inRegion = ( regionName ) ->
		areasInRegion = []
		url = "#{firebaseURL}/organizations/sra/areas/"
		onLoadPromise = firebase.queryArray(url)
		onLoadPromise.then (areas) ->
			for area in areas
				if area.region == regionName
					areasInRegion.push(area) 
		areasInRegion


	@find = ( orgId, areaId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas/#{ areaId }"
		onLoadPromise = firebase.queryObject( url )
		return onLoadPromise

	@all = ( orgId ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas"
		onLoadPromise = firebase.queryArray( url )
		return onLoadPromise

	@create = ( orgId, areaData ) ->
		url = "#{ firebaseURL }/organizations/#{ orgId }/areas"
		firebase.create( url, areaData )

	return
