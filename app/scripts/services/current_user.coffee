window.app.service "currentUser", ($rootScope) ->
	@currentUser = () ->
		return $rootScope.currentUser if $rootScope.currentUser?
		return sessionStorage.getItem('userId')

	return
