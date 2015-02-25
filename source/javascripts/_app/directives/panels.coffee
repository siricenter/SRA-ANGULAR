window.app.directive "countryPanel", ( Region ) ->
	return {
		restrict: "E"
		scope:
			country: "="
		templateUrl: "htmls/countries/panel.html"
		transclude: true
		link: ( scope, element ) ->
			Region.inCountry( 'sra', scope.country.$id )
				.then ( regions ) ->
					scope.regions = regions
	}

window.app.directive "panel", () ->
	return {
		restrict: "E"
		scope:
			title: "="
		templateUrl: "htmls/components/panel.html"
		transclude: true
	}
