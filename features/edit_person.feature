Feature: edit an existing person

  As a user
  So that I can keep people up to date
  I want to be able to edit a person

Background: Create people and go to people page
  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Rey           | Blume     | 3        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |

  And I am on the People page

  Scenario: edit person
    When I follow "People"
    Then I should be on the People page
    When I should see "Wesley"
    When I follow "Wesley"
    Then I should be redirected to the person page for "Wesley To"
    When I follow "Edit Info"
    When I fill in "Last Name" with "Nguyen"
    And I press "Update"
    Then I should be redirected to the person page for "Wesley Nguyen"
    When I follow "People"
    Then I should see "Wesley Nguyen" in the main page body
