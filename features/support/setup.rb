require 'capybara/cucumber'
require 'capybara/webkit'

Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit
Capybara.app_host = 'http://localhost:9000/#'

Before do
	page.driver.allow_url("auth.firebase.com")
	page.driver.allow_url("intense-inferno-7741.firebaseio.com")
end
