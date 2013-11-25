Feature: Access Google Calender
  As a user
  So that I can more easily manage my events
  I want to be able to see my Google Calender in the Application

  Background: Start on the home page
    Given I am on the events page
    And I follow "sign in"
    Then I should be on the events page
    Given the following Google events exist:
      |title | where |
      |Dinner|Top Dog|

  Scenario: access Calender
    When I follow Calender
    Then I should be on the calender page
    And I should see "Top Dog"
