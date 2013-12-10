Feature: filter a list of people by clicking on a field name
 
As an influencer
So that I can easily find people within my circle of influence
I want to be able to filter people by any of the existing fields.

Background: Start on the people page
  
  Given the following people exist:
  | first_name    | last_name | progress | favorite | building | hr_dept_name  |
  | John          | Gunnison  | 1        | false    | Soda     | EECS          |
  | Jeff          | Zayas     | 2        | false    | Cory     | EECS          |
  | Rey           | Blume     | 3        | false    | Soda     | EECS          |
  | Jared         | Sanchez   | 4        | false    | Cory     | MATH          |
  | Wesley        | To        | 2        | false    | Soda     | MATH          |
  | Andy          | Smith     | 4        | false    | Evans    | LSCS          |

  And I am on the people page

Scenario: Filter the people by building
        When I am on the people page
	Then I should see all of the following: "Cory", "Evans", "Soda", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	When I conditionally follow "Soda"
	Then I should not see all of the following: "Cory", "Evans", "Jeff", "Jared", "Andy"
	And I should see all of the following: "Soda", "John", "Rey", "Wesley"
	When I follow "People"
	Then I should see all of the following: "Cory", "Evans", "Soda", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	And I conditionally follow "Cory"
	Then I should not see all of the following: "Soda", "Evans", "John", "Rey", "Wesley", "Andy"
	And I should see all of the following: "Cory", "Jeff", "Jared"
	When I follow "People"
	Then I should see all of the following: "Cory", "Evans", "Soda", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	And I conditionally follow "Evans"
	Then I should not see all of the following: "Soda", "Cory", "John", "Rey", "Wesley", "Jeff", "Jared"
	And I should see all of the following: "Evans", "Andy"

Scenario: Filter the people by org
        When I am on the people page
	Then I should see all of the following: "EECS", "MATH", "LSCS", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	When I conditionally follow "EECS"
	Then I should not see all of the following: "MATH", "LSCS", "Jared", "Andy", "Wesley"
	And I should see all of the following: "EECS", "John", "Rey", "Jeff"
	When I follow "People"
	Then I should see all of the following: "EECS", "MATH", "LSCS", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	And I conditionally follow "MATH"
	Then I should not see all of the following: "EECS", "LSCS", "John", "Rey", "Jeff", "Andy"
	And I should see all of the following: "MATH", "Jared", "Wesley"
	When I follow "People"
	Then I should see all of the following: "EECS", "MATH", "LSCS", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	And I conditionally follow "LSCS"
	Then I should not see all of the following: "EECS", "MATH", "John", "Rey", "Wesley", "Jeff", "Jared"
	And I should see all of the following: "LSCS", "Andy"
