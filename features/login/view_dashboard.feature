Feature: View Dashboard
	As a user
	I want to view my dashboard
	To get an overview of my data

	@wip
	@javascript
	Scenario: Not logged in
		Given that I am not logged in
		When I visit the admin dashboard page
		Then I should be on the login page

	@wip
	@javascript
	Scenario: Admin Logged in
		Given that I am logged in as an admin
		When I visit the admin dashboard page
		Then I should be on the admin dashboard page
