describe('Login', function() {
	describe('Not logged in', function() {
		it('Has the title: Login', function() {
			browser.get('http://localhost:3000');
			expect(browser.getTitle()).toEqual('Login');
		})

		it('Lets me log in', function() {
			browser.get('http://localhost:3000');

			browser.ignoreSynchronization = true;

			var emailField = element(by.model('user.email'));
			var passwordField = element(by.model('user.password'));
			var submit = element(by.id('login'));

			emailField.sendKeys('admin@sra.com');
			passwordField.sendKeys('admin1234');

			submit.submit();

			browser.sleep(4000);
			expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/#/admin/dashboard');


		})
	})
})
