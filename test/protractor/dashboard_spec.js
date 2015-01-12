// spec.js
describe('SRA Admin Dashboard', function() {
	it('is titled "Dashboard"', function() {
		browser.get('http://localhost:9001/#/admin/dashboard');

		expect(browser.getTitle()).toEqual('Dashboard');
	});

	it('shows the user\'s full name', function() {
		browser.get('http://localhost:9001/#');

		email = element(by.id('email'));
		pass  = element(by.id('password'));
		submit = element(by.id('login'));

		email.clear().sendKeys('admin@sra.com');
		pass.clear().sendKeys('admin1234\n');
		browser.driver.sleep(3000);
		expect(element(by.id('username')).getText()).toBe('Evan Caldwell');
	});
});
