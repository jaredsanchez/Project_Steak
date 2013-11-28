Feature: edit an existing event

  As a user
  So that I can keep events up to date
  I want to be able to edit an event

Background: Create events and go to events page
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"
  And I hover over "Events"
  And I follow "Add Event"
  And I fill in "Name" with "Cocktail Party"
  And I fill in "Description" with "Party"
  And I fill in "Location" with "Cory"
  And I press "Add"
  And I am on the Events page

  @javascript
  Scenario: edit event
    When I follow "Cocktail Party"
    Then I should be on the show event page
    Then I should see "Cocktail Party"
    When I follow "Edit Info"
    When I fill in "Description" with "New Description"
    And I fill in "Location" with "New Location"
    And I press "Update"
    Then I should be on the show event page
    And I should see "New Description"
    And I should see "New Location"
