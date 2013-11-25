Feature: add a new event for people involved in an intiative
 
  As an influencer
  So that I can track events I do with people
  I want to add a new event

Background: Start on the home page
  
  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Rey           | Blume     | 3        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |

  And I am on the events page

@javascript
Scenario: add a new event
  Then I should not see "Stakeholder Dinner"
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  When I fill in "Description" with "A dinner for stake holders"
  When I fill in "Location" with "Cheeseboard"
  When I press "Add"
  Then I should be redirected to the event page for "Stakeholder Dinner"
  When I follow "Events"
  Then I should see "Stakeholder Dinner" in the main page body

