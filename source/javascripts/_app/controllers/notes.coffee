window.app.controller "NotesController", ( $scope, currentUser, firebaseURL, $firebase,$routeParams ) ->
	id = $routeParams.household
	ref = new Firebase("#{firebaseURL}/organizations/sra/notes")
	sync = $firebase(ref).$asArray().$loaded().then (notes)->
		$scope.notes = notes
