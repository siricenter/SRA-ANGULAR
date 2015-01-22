Feature: View Users
	As an administrator
	I want to see the users and their roles
	So that I can know what users are able to do in my company

	@javascript @todo
	Scenario:
		Given that I am logged in as an admin
		When I visit the users page
		Then I should be on the users page
		And I should see all the users

	@javascript @todo
	Scenario: Not logged in
		Given that I am not logged in
		When i visit the users page
		Then I should be on the admin dashboard page
