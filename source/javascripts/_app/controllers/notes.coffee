window.app.controller "NotesController", ( $scope, currentUser, firebaseURL, $firebase,$routeParams ) ->
	currentUser.requireLogin().then () ->
		$scope.id = $routeParams.household
		$scope.message = "This family has no notes taken"
		$scope.notes = []
		ref = new Firebase("#{firebaseURL}/organizations/sra/resources")
		$firebase(ref).$asArray().$loaded().then (families)->
			for family in families
				if family.name == $scope.id
					$scope.householdID = family.householdID
					console.log($scope.householdID)
					noteRef = new Firebase("#{firebaseURL}/organizations/sra/notes")
					$firebase(noteRef).$asArray().$loaded().then (notes)->
						for note in notes
							if note.noteType == "Member"
								console.log(note.householdID)
								if note.householdID == $scope.householdID
									$scope.notes.push note
									$scope.message = null
									console.log(note)

