// spec.js
describe('SRA homepage', function() {
	it('is titled "Login"', function() {
		browser.get('http://localhost:9001/#');

		expect(browser.getTitle()).toEqual('Login');
	});

	it('lets me login from the home page', function() {
		browser.get('http://localhost:9001/#');

		email = element(by.id('email'));
		pass  = element(by.id('password'));
		submit = element(by.id('login'));

		email.clear().sendKeys('admin@sra.com');
		pass.clear().sendKeys('admin1234\n');
		browser.driver.sleep(3000);
		expect(browser.getCurrentUrl()).toContain('/#/admin/dashboard');
	});
});
