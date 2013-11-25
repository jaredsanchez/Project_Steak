Feature: delete an event from the database
 
  As a user
  So that I can track events in an initiative
  I want to delete an event from the list of events in the app

Background: Start on the home page
  
  Given the following events exist:
    | name               | description  | where    | event_time               |
    | Cocktail Party     | description  | location | 2013-11-3T00:00:00+00:00 |

  And I am on the StakeHolder Mapping home page

@javascript
Scenario: delete a person from the database
  When I follow "Events"
  Then I should see "Cocktail Party"
  When I follow "Cocktail Party"
  And I follow "Edit Info"
  And I follow "Delete Event"
  And I confirm popup
  Then I should be on the events page
  And I should not see "Cocktail Party"
