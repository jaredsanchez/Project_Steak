Feature: add a new event for people involved in an intiative
 
  As a user
  So that I can track events I do with people
  I want to add a new event and specify the people involved

Background: Start on the home page
  
  Given the following people exist:
  | name          | progress |
  | John Gunnison | 1        |
  | Jeff Zayas    | 2        |
  | Rey Blume     | 3        |
  | Jared Sanchez | 4        |
  | Wesley To     | 2        |
  | Andy Smith    | 4        |

  And I am on the StakeHolder Mapping home page

Scenario: add a new event
  When I press "Add Event"
  Then I should be on the Add Event page
  When I fill in "Event Name" with "Stakeholder Dinner"
  When I fill in "Decription" with ""
  When I press "Add"
  Then I should be on the Stakeholder Mapping home page
  Then I should see "James Bond"