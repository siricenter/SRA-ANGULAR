window.app.controller "AreasIndexController", ( $scope, currentUser, Area ) ->
	currentUser.requireLogin().then () ->
		Area.all( 'sra' ).then ( areas ) ->
			$scope.areas = areas
