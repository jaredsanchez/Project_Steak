Feature: Access Google Calender
  As a user
  So that I can more easily manage my events
  I want to be able to see my Google Calendar in the Application

  Background: Start on the home page
    Given I am signed in on Google
    Given the following Google events exist:
      |title | where |
      |Dinner|Top Dog|

  @javascript
  Scenario: access Calendar
    When I hover over "Events"
    And I follow "Calendar"
    Then I should be on the calendar page
    And I should see "Top Dog"
