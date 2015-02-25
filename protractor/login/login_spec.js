helper = require('../helpers.js');
path = helper.path;
login = helper.login;

describe('Login', function() {
	describe('Not logged in', function() {
		afterEach(function () {
			helper.clearStorage();
		});

		it('Has the title: Login', function() {
			browser.get(path('/'));
			expect(browser.getTitle()).toEqual('Login');
		});

		it('Lets me log in', function() {
			login();
			expect(browser.getCurrentUrl()).toEqual(path('/dashboard'));
		});
	})

	describe('Logged in', function() {
		afterEach(function () {
			helper.clearStorage();
		});

		it('redirects to dashboard', function() {
			login();
			browser.get(path('/login'));
			browser.sleep(2000);
			expect(browser.getCurrentUrl()).toEqual(path('/dashboard'));
		});
	});
})
