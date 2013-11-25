Feature: delete a person from the database
 
  As a user
  So that I can track who is part of an initiative
  I want to delete a person from the list of people in the app

Background: Start on the home page
  Given I am signed in on Google
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
Scenario: delete a person from the database
  When I follow "People"
  Then I should see "Wesley"
  When I follow "Wesley"
  And I follow "Edit Info"
  And I follow "Delete Person"
  And I confirm popup
  Then I should be on the people page
  And I should not see "Wesley"
