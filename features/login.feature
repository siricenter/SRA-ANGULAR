Feature: Login
	As a user
	I want to login
	So that I can use the service

	@javascript
	Scenario:
		Given that I am a registered user
		When I visit the login page
		And fill out the login form
		And I should be on the dashboard page
