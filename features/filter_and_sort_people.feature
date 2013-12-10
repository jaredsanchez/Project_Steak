Feature: filter a list of people by clicking on a field name then sort them by another field
 
As an influencer
So that I can easily find people within my circle of influence
I want to be able to filter and sort people by any of the existing fields.

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

Scenario: Filter by building then sort by name
        When I am on the people page
	Then I should see all of the following: "Cory", "Evans", "Soda", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	When I follow "Soda"
	Then I should not see all of the following: "Cory", "Evans", "Jeff", "Jared", "Andy"
	And I should see all of the following: "Soda", "John", "Rey", "Wesley"
	When I follow "First Name"
	Then I should see the following people in this order: "John", "Rey", "Wesley"
	When I follow "First Name"
	Then I should see the following people in this order: "Wesley", "Rey", "John"

Scenario: Filter by org then sort by building
        When I am on the people page
	Then I should see all of the following: "EECS", "MATH", "LSCS", "John", "Jeff", "Rey", "Jared", "Wesley", "Andy"
	When I follow "EECS"
	Then I should not see all of the following: "MATH", "LSCS", "Jared", "Andy", "Wesley"
	And I should see all of the following: "EECS", "John", "Rey", "Jeff"
	When I follow "Building"
	Then I should see the following people in this order: "Jeff", "Rey", "John"
	When I follow "Building"
	Then I should see the following people in this order: "John", "Rey", "Jeff"

