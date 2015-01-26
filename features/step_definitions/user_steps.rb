When /^I visit the users page$/ do
	visit 'http://localhost:9000/#/admin/users'
end

Then /^I should see all the users in my company and their designated roles$/ do
	expect(current_url).to eq('http://localhost:9000/#/admin/users')
end
