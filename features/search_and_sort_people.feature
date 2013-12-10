Feature: search a list of people then sort the results by another field
 
As an influencer
So that I can easily find people within my circle of influence
I want to be able to search for and sort people

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

Scenario: search for a person by name then sort by building
	When I follow "People"
	And I fill in "search_term" with "John Smith"
	And I press "Search"
	Then I should not see all of the following: "Jeff", "Rey", "Jared", "Wesley"
	And I should see all of the following: "John", "Gunnison", "Andy", "Smith", "Jacob"
	When I follow "Building"
	Then I should see the following people in this order: "Andy", "Gunnison", "Jacob"
	When I follow "Building"
	Then I should see the following people in this order: "Gunnison", "Jacob", "Andy"

