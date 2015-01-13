describe "SRA homepage", ->
	page =
		email: element(By.id("email"))
		password: element(By.id("password"))
		submit: element(By.id("login"))
		wait: (time) -> browser.driver.sleep time
		name: element((By.id("username")))

	it "is titled \"Dashboard\"", ->
		browser.get "http://localhost:9001/#/admin/dashboard"
		expect(browser.getTitle()).toEqual "Dashboard"
		return

	it "shows my full name", ->
		browser.get "http://localhost:9001/#/"

		page.email.clear().sendKeys "admin@sra.com"
		page.password.clear().sendKeys "admin1234"
		page.submit.click()

		page.wait(3000)

		page.name.getText().then((text) ->
			expect(text).toBe('{{firstName}} {{lastName}}'))
		return

	return
