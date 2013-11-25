Feature: Add a Google Event
  As a user
  So that I can use Google Calender to Add an Event
  I want to be able to add a Google Event


  @omniauth_test
  Scenario: add a Google Event
    Given I am signed in on Google
    And I am on the home page
    When I follow Add Event
    Then I should see Event details
    When I fill in title with "Dinner"
    And I fill in Where with "Top Dog"
    And I press Save
    Then I should be on the calender page
    And I should see "Dinner"
