Feature: add people to events
  As a user 
  So that I can track the people who attented an event
  I want to add a person to an event

Background:
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"
  Given I am on the events page
  And I hover over "Events"
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

  @javascript
  Scenario: show event page
    When I follow "Events"
    And I follow "Stakeholder Dinner"
    Then I should be redirected to the event page for "Stakeholder Dinner"
    And I should see "Stakeholder Dinner"

  @javascript
  Scenario: add a person to event
    When I follow "Events"
    When I follow "Stakeholder Dinner"
    And I select "John Gunnison" from "person_person_id"
    And I press "Add Person"
    Then I should be redirected to the event page for "Stakeholder Dinner"
    And I should see "John Gunnison"

  @javascript
  Scenario: add a duplicate person to event
    When I follow "Events"
    When I follow "Stakeholder Dinner"
    And I select "John Gunnison" from "person_person_id"
    And I press "Add Person"
    Then I should be redirected to the event page for "Stakeholder Dinner"   
    And I should see "John Gunnison"
    When I select "John Gunnison" from "person_person_id"
    And I press "Add Person"
    Then I should see "already"


  @javascript
  Scenario: add multiple people to an event
    When I follow "Events"
    When I follow "Stakeholder Dinner"
    And I select "John Gunnison" from "person_person_id"
    And I press "Add Person"
    Then I should be redirected to the event page for "Stakeholder Dinner"
    And I should see "John Gunnison"
    When I select "Andy Smith" from "person_person_id"
    And I press "Add Person"
    Then I should be redirected to the event page for "Stakeholder Dinner"
    And I should see "John Gunnison"
    And I should see "Andy Smith"



