Feature: Login
	As an administrator
	I want to see the users and their roles
	So that I can know what users are able to do in my company

	@javascript
	Scenario:
		Given that I am logged in as an administrator
		When I visit the users page
		Then I should see all the users in my company and their designated roles
