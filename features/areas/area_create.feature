Feature: User creates an area
	As a user
	I want to create a new area
	So I can begin working with resources in that area

	@javascript
	Scenario: Admin creates area
		Given that I am logged in as an admin
		When I visit the create area page
		And I create an area called "The Bronx" in the region of "New York"
		Then I should be on the area's page called "The Bronx"
		And I should see "The Bronx"'s name
