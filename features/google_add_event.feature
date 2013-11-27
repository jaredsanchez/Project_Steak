Feature: Add a Google Event
  As a user
  So that I can use Google Calender to Add an Event
  I want to be able to add a Google Event


  Background: Start on the home page
    
    Given I am on the home page
    Then I should see "Sign In"
    When I follow "Sign In"
    And I conditionally fill in "Email" with "projectsteak@gmail.com"
    And I conditionally fill in "Passwd" with "steak222"
    Then I conditionally press "Sign in"
    Then I conditionally press "Accept"

  @omniauth_test
  @javascript
  Scenario: add a Google Event
    And I am on the home page
    When I hover over "Events"
    When I follow "Add Event"
    When I fill in "Name" with "Dinner"
    And I fill in "Location" with "Top Dog"
    And I press "Add"
    Then I should see "Top Dog"
    And I should see "Dinner"

