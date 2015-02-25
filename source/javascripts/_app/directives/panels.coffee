window.app.directive "regionPanel", ( Area ) ->
	return {
		restrict: "E"
		scope:
			region: "="
		templateUrl: "htmls/regions/panel.html"
		transclude: true
		link: ( scope, element ) ->
			Area.inRegion( "sra", scope.region.$id )
				.then ( areas ) ->
					scope.areas = areas
	}

window.app.directive "countryPanel", ( Region ) ->
	return {
		restrict: "E"
		scope:
			country: "="
		templateUrl: "htmls/countries/panel.html"
		transclude: true
		link: ( scope, element ) ->
			Region.inCountry( "sra", scope.country.$id )
				.then ( regions ) ->
					scope.regions = regions
	}

window.app.directive "panel", () ->
	return {
		restrict: "E"
		scope:
			title: "="
			href: "="
		templateUrl: "htmls/components/panel.html"
		transclude: true
	}
