Feature: search for people within the database
 
As an influencer
So that I can easily find people within my circle of influence
I want to be able to search for people by any of the existing fields

Background: Start on the home page
  Given I am signed in on Google
  Given the following people exist:
  | first_name    | last_name | progress | favorite | hr_dept_name  | building | room_number |
  | John          | Gunnison  | 1        | false    | EECS          | Soda     | 19          |
  | Jeff          | Zayas     | 2        | false    | EECS          | Cory     | 20          |
  | Rey           | Blume     | 3        | false    | MATH          | Evans    | 21          |
  | Jared         | Sanchez   | 4        | false    | LSCS          | Soda     | 22          |
  | Wesley        | To        | 2        | false    | LSCS          | Soda     | 23          |
  | Andy          | Smith     | 4        | false    | MATH          | Dwinelle | 24          |
  | John          | Jacob     | 4        | false    | MUSC          | Soda     | 25          |
  And I am on the StakeHolder Mapping home page

Scenario: search for a person by first name
	When I follow "People"
	And I fill in "search_term" with "Wesley"
	And I press "Search"
	Then I should not see all of the following: "John", "Jeff", "Rey", "Jared", "Andy", "John"
	And I should see "Wesley"

Scenario: search for a person by last name
	When I follow "People"
	And I fill in "search_term" with "To"
	And I press "Search"
	Then I should not see all of the following: "John", "Jeff", "Rey", "Jared", "Andy", "John"
	And I should see "Wesley"

Scenario: search for a person by name
	When I follow "People"
	And I fill in "search_term" with "John Smith"
	And I press "Search"
	Then I should not see all of the following: "Jeff", "Rey", "Jared", "Wesley"
	And I should see all of the following: "John", "Gunnison", "Andy", "Smith", "Jacob"

Scenario: search for a person by org
	When I follow "People"
	And I fill in "search_term" with "MATH"
	And I press "Search"
	Then I should not see all of the following: "John", "Jeff", "Jared", "Wesley", "John"
	And I should see all of the following: "Andy", "Rey"

Scenario: search for a person by building
	When I follow "People"
	And I fill in "search_term" with "Dwinelle"
	And I press "Search"
	Then I should not see all of the following: "John", "Jeff", "Jared", "Wesley", "Rey", "John"
	And I should see all of the following: "Andy"
@javascript
Scenario: search for a person by department and name
	When I follow "People"
	And I fill in "search_term" with "John MUSC"
	And I press "Search"
	Then I should not see all of the following: "Jeff", "Jared", "Wesley", "Rey"
	And I should see all of the following: "John", "Jacob", "Soda", "MUSC", "Gunnison"

Scenario: search for a person with non-existent search term (no results)
	When I follow "People"
	And I fill in "search_term" with "Homer Simpson"
	And I press "Search"
	Then I should not see all of the following: "Homer", "John", "Jeff", "Jared", "Wesley", "Rey", "Andy"
