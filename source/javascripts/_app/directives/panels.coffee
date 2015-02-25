window.app.directive "householdPanel", () ->
	return {
		restrict: "E"
		scope:
			household: "="
		templateUrl: "htmls/households/panel.html"
	}

window.app.directive "areaPanel", ( Household ) ->
	return {
		restrict: "E"
		scope:
			area: "="
		templateUrl: "htmls/areas/panel.html"
		link: ( scope, element ) ->
			Household.inArea( "sra", scope.area.$id )
				.then ( households ) ->
					scope.households = households
	}

window.app.directive "regionPanel", ( Area ) ->
	return {
		restrict: "E"
		scope:
			region: "="
		templateUrl: "htmls/regions/panel.html"
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
