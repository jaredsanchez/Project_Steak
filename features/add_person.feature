Feature: add a new person involved in an intiative
 
  As a user
  So that I can track who is part of an initiative
  I want to add a new person to the list of people involved in the initiative

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

Scenario: add a new person to the intitiative
  Then I should not see "James Bond"
  When I press "Add Person"
  Then I should be on the Add Person page
  When I fill in "name" with "James Bond"
  When I fill in "progress" with "3"
  When I press "Add"
  Then I should be on the Stakeholder Mapping home page
  Then I should see "James Bond"