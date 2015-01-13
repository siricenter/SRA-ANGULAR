describe "SRA homepage", ->
	it "is titled \"Login\"", ->
		browser.get "http://localhost:9001/#"
		expect(browser.getTitle()).toEqual "Login"
		return

	it "lets me login from the home page", ->
		browser.get "http://localhost:9001/#"
		email = element(By.id("email"))
		pass = element(By.id("password"))
		submit = element(By.id("login"))
		email.clear().sendKeys "admin@sra.com"
		pass.clear().sendKeys "admin1234\n"
		browser.driver.sleep 3000
		expect(browser.getCurrentUrl()).toContain "/#/admin/dashboard"
		return

	return
