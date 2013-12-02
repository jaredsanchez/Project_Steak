Feature: Refresh the Google calendar page
 
  As a user
  So that I can be up to date with my events
  I want to be able to refresh my Google Calendar from within the app

Background: Start on the home page
  
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"


@javascript
Scenario: refresh the Google Calendar
  I am on the home page
  I should see "Project Steak"
  When I hover over "Events"
  And I follow "Calendar"
  And I click the image for "refresh_button"
  Then I should see "Project Steak"
