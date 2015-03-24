window.app.controller "NotesController", ( $scope, currentUser, firebaseURL, $firebase,$routeParams ) ->
	$scope.id = $routeParams.household
	ref = new Firebase("#{firebaseURL}/organizations/sra/resources")
	$firebase(ref).asArray().loaded().then (families)->
		for family in families
			console.log(family)
	#note = new Firebase("#{firebaseURL}/organizations/sra/notes")
	#sync = $firebase(ref).$asArray().$loaded().then (notes)->
	#	$scope.notes = notes

