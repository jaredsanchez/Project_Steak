Feature: Login with LinkedIn Account

  As an influencer
  So I can view my LinkedIn connections in my people list
  I want to log in with my LinkedIn Account

Scenario: Log in with LinkedIn Account
  Given I am on the Stakeholder Mapping Home Page
  I should see "login_linkedin"
  When I log in with Linkedin using "test_email@gmail.com" and password "password"
  I should see "Log in successful"

Scenario: Invalid Logins should redirect to home page 
  Given I am on the Stakeholder Mapping Home Page
  When I log in with Linkedin using "invalidemail" and password "?"
  I should see "Error: Invalid login"

