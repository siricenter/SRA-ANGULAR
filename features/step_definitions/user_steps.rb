When /^I visit the users page$/ do
	visit "#{app_host}/admin/users"
end

Then /^I should see all the users in my company and their designated roles$/ do
	expect(current_url).to eq("#{app_host}/admin/users")
end

Given(/^I am on the admin dashboard$/) do
	visit "#{app_host}/admin/dashboard"
end

When(/^I visit the create user page$/) do
	visit "#{app_host}/admin/users/new"
end

When(/^I create a user named "(.*?)" "(.*?)"$/) do |fname, lname|
	within "#user" do
		fill_in 'user_fname', with: fname
		fill_in 'user_lname', with: lname
		fill_in 'user_email', with: "fake@fake.com"
		fill_in 'user_password', with: "mypass01"

		click_on 'Submit'
		sleep 2
	end
end
