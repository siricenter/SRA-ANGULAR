Given /^that I am not logged in$/ do
end

When /^I visit the dashboard page$/ do
	visit 'http://localhost:9000/#/dashboard'
end

Then /^I should be on the login page$/ do
	expect(current_url).to eq('http://localhost:9000/#/login')
end

Given /^that I am logged in as an admin$/ do
	visit 'http://localhost:9000/#/login'

	fill_in 'email', with: 'admin@sra.com'
	fill_in 'password', with: 'admin1234'

	click_button 'Login'

	sleep 2
end

When(/^I visit the admin dashboard page$/) do
	visit 'http://localhost:9000/#/admin/dashboard'
end
