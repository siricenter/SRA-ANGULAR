module.exports = {
	path: function(path) {
		return 'http://localhost:3000' + path;
	},

	id: function(elementID) {
		return element(by.id(elementID))
	},

	clearStorage: function () {
		browser.executeScript('window.sessionStorage.clear();');
		browser.executeScript('window.localStorage.clear();');
	},

	login: function() {
		browser.get('http://localhost:3000');

		browser.ignoreSynchronization = true;

		var emailField = element(by.model('user.email'));
		var passwordField = element(by.model('user.password'));
		var submit = element(by.id('login'));

		emailField.sendKeys('admin@sra.com');
		passwordField.sendKeys('admin1234');

		submit.submit();

		browser.sleep(4000);
	}
};
