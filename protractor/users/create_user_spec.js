helper = require('../helpers.js');
path = helper.path;

describe('Create User', function() {
	afterEach(function () {
		helper.clearStorage();
	});

	describe('Create User page', function() {
		it('requires admin privileges', function() {
			browser.get(path('/admin/users/new'));
			browser.sleep(1500);
			expect(browser.getCurrentUrl()).toEqual(path('/'))
		})
	});
});
