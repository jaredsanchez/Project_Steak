Feature: display a list of events on the events page and be able to sort them
 
  As an influencer
  So that I can easily find events
  I want to be able to sort a list of events

Background: Start on the events page
  Given I am signed in on Google
  Given the following events exist:
    | name               | description  | where       | event_time               |
    | Cocktail Party     | description  | location    | 2013-11-3T00:00:00+00:00 |
    | Stakeholder Dinner | steak dinner | someplace   | 2013-11-5T00:00:00+00:00 |
    | Something Else     | miscellanous | undisclosed | 2013-11-7T00:00:00+00:00 |

  And I am on the events page

Scenario: display a list of events whose default order is by name ascending
  I should see the following events in this order: 'Cocktail Party', 'Something Else', 'Stakeholder Dinner'


Scenario: sort the events by alphabetical name descending order
  When I follow "Events"
  When I follow "Name"
  Then I should see the following events in this order: 'Cocktail Party', 'Something Else', 'Stakeholder Dinner'


Scenario: sort the events by alphabetical name ascending order
  When I follow "Events"
  When I follow "Name"
  When I follow "Name"
  Then I should see the following events in this order: 'Stakeholder Dinner', 'Something Else', 'Cocktail Party'

