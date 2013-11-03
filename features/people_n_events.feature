Feature: add people to events
  As a user 
  So that I can track the people who attented an event
  I want to add a person to an event

Background:
  Given I am on the events page
  Given the following events exist:
    | name                | description           | where         | event_time                |
    | Stakeholder Dinner  | dinner w/ stakeholder | Cheeseboard   | 2013-11-1T00:00:00+00:00  |


  Scenario: show event page
    When I follow "Stakeholder Dinner"
    Then I should be on the show event page
    And I should see "Stakeholder Dinner"

  Scenario: delete event
    When I follow "Stakeholder Dinner"
    Then I should be on the show event page
    When I press "Delete"
    Then I shold be on the events page
    And I should not see "Stakeholder Dinner"

  Scenario: add a person to event
    When I follow "Stakeholder Dinner"
    Then I should be on the show event page
    When I press "Add Person"
    And I select "Jeff Zayas"
    Then "Jeff Zayas" should be attending the event "Stakeholder Dinner"


    
