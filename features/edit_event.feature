Feature: edit an existing event

  As a user
  So that I can keep events up to date
  I want to be able to edit an event

Background
  Given I am on the events page
  And the following events exist:
    | name               | description  | where    | event_time               |
    | Cocktail Party     | description  | location | 2013-11-3T00:00:00+00:00 |

  Scenario: edit event
    When I follow "Cocktail Party"
    Then I should be on the show page for "Cocktail Party"
    When I click "Edit Event"
    Then I should be on the edit page for "Cocktail Party"
    When I fill in "Description" with "New description"
    And I fill in "Location" with "New location"
    And I press "Update Event"
    Then I should be on the show page for "Cocktail Party"
    And I should see "New Description"
    And I should see "New Location"
