require 'capybara/cucumber'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
	options = {
		js_errors: false,
		debug: false
	}
	Capybara::Poltergeist::Driver.new(app, options)
end

Given /^that I am a registered user$/ do
end

When /^I visit the login page$/ do
	visit 'http://localhost:9000/#/login'
end

When /^fill out the login form$/ do
	fill_in 'email', with: 'admin@sra.com'
	fill_in 'password', with: 'admin1234'

	click_button 'Login'
	sleep 3
end

Then /^I should be on the dashboard page$/ do
	expect(current_url).to eq('http://localhost:9000/#/admin/dashboard')
end
