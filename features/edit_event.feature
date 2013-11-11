Feature: edit an existing event

  As a user
  So that I can keep events up to date
  I want to be able to edit an event

Background: Create events and go to events page
  Given the following events exist:
    | name               | description  | where    | event_time               |
    | Cocktail Party     | description  | location | 2013-11-3T00:00:00+00:00 |

  And I am on the Events page

  Scenario: edit event
    When I follow "Cocktail Party"
    Then I should be on the show event page
    Then I should see "Cocktail Party"
    When I follow "Edit Event"
    When I fill in "Description" with "New Description"
    And I fill in "Location" with "New Location"
    And I press "Update Event"
    Then I should be on the show event page
    And I should see "New Description"
    And I should see "New Location"
