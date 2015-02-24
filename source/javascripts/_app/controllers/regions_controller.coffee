window.app.controller "RegionsIndexController", ( $scope, Region, currentUser ) ->
	currentUser.requireLogin().then () ->
		Region.all( 'sra' ).then ( regions ) ->
			$scope.regions = regions
