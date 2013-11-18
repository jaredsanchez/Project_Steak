Feature: Add a Google Event
  As a user
  So that I can use Google Calender to Add an Event
  I want to be able to add a Google Event

  Background: Start on the home page
    Given I am on the home page
    And I have signed in with Google

  Scenario: add a Google Event
    When I follow Add Event
    Then I should see Event details
    When I fill in title with "Dinner"
    And I fill in Where with "Top Dog"
    And I press Save
    Then I should be on the calender page
    And I should see "Dinner"
