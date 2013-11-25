Feature: Add a Google Event
  As a user
  So that I can use Google Calender to Add an Event
  I want to be able to add a Google Event


  @omniauth_test
  @javascript
  Scenario: add a Google Event
    Given I am signed in on Google
    And I am on the home page
    When I hover over "Events"
    When I follow "Add Event"
    When I fill in "Name" with "Dinner"
    And I fill in "Location" with "Top Dog"
    And I press "Add"
    Then I should be on the events page
    And I should see "Dinner"
