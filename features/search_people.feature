Feature: search for people within the database
 
As an influencer
So that I can easily find people within my circle of influence
I want to be able to search for people by any of the existing fields

Background: Start on the home page
  Given I am signed in on Google
  Given the following people exist:
  | first_name    | last_name | progress | favorite | org  | building |
  | John          | Gunnison  | 1        | true     | EECS | Soda     |
  | Jeff          | Zayas     | 2        | true     | EECS | Cory     |
  | Rey           | Blume     | 3        | true     | MATH | Evans    |
  | Jared         | Sanchez   | 4        | false    | LSCS | Soda     |
  | Wesley        | To        | 2        | false    | LSCS | Soda     |
  | Andy          | Smith     | 4        | false    | MATH | Dwinelle |
  | John          | Jacob     | 4        | false    | MUSC | Soda     |
  And I am on the StakeHolder Mapping home page

Scenario: search for a person by first name
	When I follow "People"
	And I fill in "Wesley" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "John", "Jeff", "Rey", "Jared", "Andy", "John"
	And I should see "Wesley"

Scenario: search for a person by last name
	When I follow "People"
	And I fill in "To" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "John", "Jeff", "Rey", "Jared", "Andy", "John"
	And I should see "Wesley"

Scenario: search for a person by name
	When I follow "People"
	And I fill in "John Smith" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "Jeff", "Rey", "Jared", "Wesley", "Jacob"
	And I should see all of the following: "John", "Gunnison", "Andy", "Smith"

Scenario: search for a person by org
	When I follow "People"
	And I fill in "math" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "John", "Jeff", "Jared", "Wesley", "John"
	And I should see all of the following: "Andy", "Rey"

Scenario: search for a person by building
	When I follow "People"
	And I fill in "Dwinelle" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "John", "Jeff", "Jared", "Wesley", "Rey", "John"
	And I should see all of the following: "Andy"

Scenario: search for a person by building and name
	When I follow "People"
	And I fill in "John MUSC" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "Jeff", "Jared", "Wesley", "Rey", "Gunnison"
	And I should see all of the following: "John", "Jacob", "Morrison", "MUSC"

Scenario: search for a person with non-existent search term (no results)
	When I follow "People"
	And I fill in "Homer Simpson" in the "Search" field
	And I follow "Search"
	Then I should not see all of the following: "John", "Jeff", "Jared", "Wesley", "Rey", "Andy", John"
	And I should see "No Results Found"
