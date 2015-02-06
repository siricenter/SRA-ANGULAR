Feature: Admin creates user
	As an admin
	I want to create a user and add them to my organization
	So my organization can expand

	Ideally, creating a user and adding them to the organization uses two 
	different services - one for creating the user, and one for adding any user 
	to an organization.

	@wip
	@javascript
	Scenario: Admin creates new user
		Given that I am logged in as an admin
		And I am on the admin dashboard
		When I visit the create user page
		And I create a user named "Juan" "Jimenez"
		Then a success message should show up
