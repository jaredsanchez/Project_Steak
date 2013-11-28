Feature: display a list of events on the events page and be able to sort them
 
  As an influencer
  So that I can easily find events
  I want to be able to sort a list of events

Background: Start on the events page
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
  And I fill in "Description" with "description"
  And I fill in "Location" with "location"
  And I press "Add"
  And I hover over "Events"
  And I follow "Add Event"
  And I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "steak dinner"
  And I fill in "Location" with "someplace"
  And I press "Add"
  And I hover over "Events"
  And I follow "Add Event"
  And I fill in "Name" with "Something Else"
  And I fill in "Description" with "miscellaneous"
  And I fill in "Location" with "undisclosed"
  And I press "Add"

@javascript
Scenario: display a list of events whose default order is by name ascending
  When I follow "Events"
  Then I should see the following events in this order: "Cocktail Party", "Something Else", "Stakeholder Dinner"

@javascript
Scenario: sort the events by alphabetical name descending order
  When I follow "Events"
  When I follow "Name"
  Then I should see the following events in this order: "Cocktail Party", "Something Else", "Stakeholder Dinner"

@javascript
Scenario: sort the events by alphabetical name ascending order
  When I follow "Events"
  When I follow "Name"
  When I follow "Name"
  Then I should see the following events in this order: "Stakeholder Dinner", "Something Else", "Cocktail Party"

