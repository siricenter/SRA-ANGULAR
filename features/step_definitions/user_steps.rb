When /^I visit the users page$/ do
	visit "#{app_host}/admin/users"
end

Then /^I should see all the users in my company and their designated roles$/ do
	expect(current_url).to eq("#{app_host}/admin/users")
end
