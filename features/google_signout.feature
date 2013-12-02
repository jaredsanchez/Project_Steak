Feature: Sign out of Google
 
  As a user
  So that I can protect my privacy
  I want to be able to log out of my Google account

Background: Start on the home page
  
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"


@javascript
Scenario: log out of Google
  Then I should see "Project Steak"
  When I mouseover the element "log_button"
  And I follow "Sign Out"
  Then I should be on the events page
  And I should see "Sign In"
