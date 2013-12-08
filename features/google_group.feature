Feature: Adding Groups to Events
  As a user
  So that I can invite multiple people to an event at once
  I want to add groups of individuals to events


Background: Start on the home page
  Given the following people exist:
  | first_name    | last_name | progress | favorite | email       | 
  | Jeff          | Zayas     | 2        | true     | j@gmail.com |
  | Andy          | Smith     | 4        | false    | a@gmail.com |

  And the group named "Partners" exists with the following people:
  | first_name    | last_name |
  | Jeff          | Zayas     |  
  | Andy          | Smith     |

  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"
  And I am on the Events page

  @javascript
 Scenario: group member names should appear when group is added
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I press "Add"
  Then I should see "Stakeholder Dinner" in the main page body
  Then I select "Partners" from "group_group_id"
  And I press "Add Group"
  Then I should see "Jeff Zayas"
  And I should see "Andy Smith"


 @javascript
 Scenario: Group name should appear when group is added
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I press "Add"
  Then I select "Partners" from "group_group_id"
  And I press "Add Group"
  Then I should see "Partners" before "Andy Smith"

  @javascript
  Scenario: Send out Google Invites to Group
  When I hover over "Events"
  And I follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I press "Add"
  Then I select "Partners" from "group_group_id"
  And I press "Add Group"
  When I press "Send Google Calendar Invites"
  Then I should see "Emails sent!"
