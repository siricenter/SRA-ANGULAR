When(/^I visit the create area page$/) do
	visit "/areas/new"
end

When(/^I create an area called "(.*)" in the region of "(.*)"$/) do |area, region|
	within('#new-area-form') do
		fill_in :'new-area-region', with: region
		fill_in :'new-area-name', with: area

		click_on 'Submit'
	end
end

Then(/^I should be on the area's page called "(.*)"$/) do |area|
end

Then(/^I should see "(.*)"'s name$/) do |area|
	expect(page.has_content?(area)).to be true
end
