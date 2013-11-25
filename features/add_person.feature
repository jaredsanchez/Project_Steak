Feature: add a new person to the database
 
  As a user
  So that I can track who is part of an initiative
  I want to add a new person to the list of people in the app

Background: Start on the home page
  
  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Rey           | Blume     | 3        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |

  And I am on the StakeHolder Mapping home page

@javascript
Scenario: add a new person to the database
  Then I should not see "James Bond"
  When I hover over "People"
  And I follow "Add Person"
  And I fill in "First Name" with "James"
  And I fill in "Last Name" with "Bond"
  And I select "Aware" from the "Progress" dropdown menu
  When I press "Add"
  Then I should be redirected to the "James Bond" page
  When I follow "People"
  Then I should see "James Bond" in the main page body
