describe('Login', function() {
	describe('Not logged in', function() {
		it('Has the title: Login', function() {
			browser.get('http://localhost:3000');
			expect(browser.getTitle()).toEqual('Login');
		})
	})
})
