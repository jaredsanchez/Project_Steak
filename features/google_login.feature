Feature: Log In with Google
 
  As a user
  So that I can use my Google calenders
  I want to be able to log in with my Google account

Background: Start on the home page
  
  Given I am on the home page
  Then I should see "sign in"
  When I follow "sign in"
  And I fill in "Email" with "projectsteak@gmail.com"
  And I fill in "Passwd" with "steak222"
  Then I click "signIn"
  And I should see "Greetings"


Scenario: add a new person to the intitiative
  Then I should not see "James Bond"
  When I follow "Add a new stakeholder"
  Then I should be on the Add Person page
  When I fill in "Name" with "James Bond"
  When I fill in "Progress" with "3"
  When I press "Add"
  Then I should be on the StakeHolder Mapping home page
  Then I should see "James Bond"
