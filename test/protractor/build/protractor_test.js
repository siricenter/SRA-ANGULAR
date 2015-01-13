(function() {
  describe("SRA homepage", function() {
    var page;
    page = {
      email: element(By.id("email")),
      password: element(By.id("password")),
      submit: element(By.id("login")),
      wait: function(time) {
        return browser.driver.sleep(time);
      },
      name: element(By.id("username"))
    };
    it("is titled \"Dashboard\"", function() {
      browser.get("http://localhost:9001/#/admin/dashboard");
      expect(browser.getTitle()).toEqual("Dashboard");
    });
    it("shows my full name", function() {
      browser.get("http://localhost:9001/#/");
      page.email.clear().sendKeys("admin@sra.com");
      page.password.clear().sendKeys("admin1234");
      page.submit.click();
      page.wait(3000);
      page.name.getText().then(function(text) {
        return expect(text).toBe('{{firstName}} {{lastName}}');
      });
    });
  });

}).call(this);

(function() {
  describe("SRA homepage", function() {
    it("is titled \"Login\"", function() {
      browser.get("http://localhost:9001/#");
      expect(browser.getTitle()).toEqual("Login");
    });
    it("lets me login from the home page", function() {
      var email, pass, submit;
      browser.get("http://localhost:9001/#");
      email = element(By.id("email"));
      pass = element(By.id("password"));
      submit = element(By.id("login"));
      email.clear().sendKeys("admin@sra.com");
      pass.clear().sendKeys("admin1234\n");
      browser.driver.sleep(3000);
      expect(browser.getCurrentUrl()).toContain("/#/admin/dashboard");
    });
  });

}).call(this);
