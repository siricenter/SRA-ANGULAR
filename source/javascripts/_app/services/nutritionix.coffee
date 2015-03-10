window.app.service "Nutrionix",($http) ->
	@search = (query) ->
		post = {
			method: 'POST',
			url: 'https://api.nutritionix.com/v1_1/search',
			headers: {
				'Content-Type': 'application/json'
			},
			data: {
				"appId": "f67bfd42",
				"appKey": "c69bd76b98dd8d4e1fd629241b3bb199",
				"query": query
			},
		}
		$http(post).success((data)->
			results = data
		).error((error)->
			results = error
		)
	return
