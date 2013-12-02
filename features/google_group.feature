Feature: Adding Groups to Events
  As a user
  So that I can invite multiple people to an event at once
  I want to add groups of individuals to events


Background: Start on the home page
  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |

  And the group named "Partners" exists with these people exist:
  | first_name    | last_name |
  | John          | Gunnison  | 
  | Jeff          | Zayas     | 
  | Jared         | Sanchez   | 
  | Wesley        | To        | 
  | Andy          | Smith     |


 Scenario: group member names should appear when group is added
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I fill in "Group" with "Partners"
  And I press "Add"
  Then I should see "Stakeholder Dinner" in the main page body
  And I should see "John Gunnison"
  And I should see "Jeff Zayas"
  And I should see "Jared Sanchez"
  And I should see "Wesley To"
  And I should see "Andy Smith"

 Scenario: group member names should appear when group is added
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I fill in "Group" with "FakeGroupNAME"
  And I press "Add"
  Then I should see "Error: Group name 'FakeGroupNAME' not found"
  And I should be on the Add Event Page

 Scenario: Group name should appear when group is added
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I fill in "Group" with "Parterns"
  And I press "Add"
  Then I should see "Partners" before "John Gunnison"

 



