Feature: add people to events
  As a user 
  So that I can track the people who attented an event
  I want to add a person to an event

Background:
  Given I am on the events page
  And I follow "Add Event"
  And I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "Discussion about the API"
  And I fill in "Location" with "Cory"
  And I press "Add"
  Then I should be redirected to the event page for "Stakeholder Dinner"
  And I should see "Stakeholder Dinner"

  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Rey           | Blume     | 3        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |



  Scenario: show event page
    When I follow "Events"
    And I follow "Stakeholder Dinner"
    Then I should be redirected to the event page for "Stakeholder Dinner"
    And I should see "Stakeholder Dinner"

  Scenario: add a person to event
    When I follow "Events"
    When I follow "Stakeholder Dinner"
    And I fill in "Name" with "Jeff Zayas"
    And I press "Add"
    Then I should be redirected to the event page for "Stakeholder Dinner"
    And I should see "Jeff Zayas"

  Scenario: add a non-existent person to event
    When I follow "Events"
    When I follow "Stakeholder Dinner"
    And I fill in "Name" with "Puff The Magic Dragon"
    And I press "Add"
    Then I should be redirected to the event page for "Stakeholder Dinner"   
    And I should not see "Puff The Magic Dragon" 
