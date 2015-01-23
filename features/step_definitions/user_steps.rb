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

When /^I visit the users page$/ do
	visit 'http://localhost:9000/#/admin/users'
end

Then /^I should see all the users in my company and their designated roles$/ do
	expect(current_url).to eq('http://localhost:9000/#/admin/users')
end
