Feature: add a new event for people involved in an intiative
 
  As an influencer
  So that I can track events I do with people
  I want to add a new event

Background: Start on the home page
  
  Given the following people exist:
  | name          | progress |
  | John Gunnison | 1        |
  | Jeff Zayas    | 2        |
  | Rey Blume     | 3        |
  | Jared Sanchez | 4        |
  | Wesley To     | 2        |
  | Andy Smith    | 4        |

  And I am on the events page

Scenario: add a new event
  Then I should not see "Stakeholder Dinner"
  When I follow "Add New Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  When I fill in "Description" with "A dinner for stake holders"
  When I fill in "Location" with "Cheeseboard"
  When I press "Add Event"
  Then I should be on the events page

