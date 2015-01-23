window.app.service "currentUser", ($rootScope) ->
	@currentUser = () ->
		return $rootScope.currentUser if $rootScope.currentUser?
		stored = sessionStorage.getItem('userId')
		return stored if stored?
		return undefined
	return
