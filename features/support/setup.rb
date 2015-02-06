require 'capybara/cucumber'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.app_host = 'http://localhost:4567/#'

def app_host
	return Capybara.app_host
end

#Before do
#	page.driver.allow_url("auth.firebase.com")
#	page.driver.allow_url("intense-inferno-7741.firebaseio.com")
#end
