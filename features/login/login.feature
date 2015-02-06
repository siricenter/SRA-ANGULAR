Feature: Login
	As a user
	I want to login
	So that I can use the service

	@wip
	@javascript
	Scenario:
		Given that I am a registered user
		When I visit the login page
		And I fill out the login form
		Then I should be on the admin dashboard page
