Feature: add a new event for people involved in an intiative
 
  As an influencer
  So that I can track events I do with people
  I want to add a new event

Background: Start on the home page
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"
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
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I press "Add"
  Then I should see "Stakeholder Dinner" in the main page body

