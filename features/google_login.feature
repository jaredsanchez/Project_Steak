Feature: Log In with Google
 
  As a user
  So that I can use my Google calenders
  I want to be able to log in with my Google account

Background: Start on the home page
  
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"


@javascript
Scenario: add a new person to the intitiative
  Then I should not see "James Bond"
  When I hover over "People"
  And I follow "Add Person"
  Then I should be on the Add Person page
  When I fill in "First Name" with "James"
  When I fill in "Last Name" with "Bond"
  And I select "Trying" from the "Progress" dropdown menu
  When I press "Add"
  Then I should be redirected to the person page for "James Bond"
  When I follow "People"
  Then I should see "James Bond" in the main page body

@javascript 
Scenario: log out of a user session
Then I should see "Project Steak"
When I hover over "Project Steak"
Then I should see "Sign Out"
When I follow "Sign Out"
Then I should see "Sign In"
