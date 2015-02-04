Given /^that I am a registered user$/ do
end

When /^I visit the login page$/ do
	visit 'http://localhost:9000/#/login'
end

When /^I fill out the login form$/ do
	fill_in 'email', with: 'admin@sra.com'
	fill_in 'password', with: 'admin1234'

	click_button 'Login'

	sleep 2
end

Then /^I should be on the admin dashboard page$/ do
	expect(current_url).to eq("#{app_host}/admin/dashboard")
end
