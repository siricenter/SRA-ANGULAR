Feature: User creates an area
	As a user
	I want to create a new area
	So I can begin working with resources in that area

	@wip
	Scenario: Admin creates area
		Given that I am logged in as an admin
		When I visit the create area page
		And I fill out the new area form
		Then I should be on the area's page
		And I should see the area's name
