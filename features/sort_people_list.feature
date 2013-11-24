Feature: display a list of people on the people page and be able to sort them
 
  As an influencer
  So that I can easily find people
  I want to be able to sort a list of people

Background: Start on the people page
  
  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Rey           | Blume     | 3        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |

  And I am on the people page

Scenario: display a list of people whose default order is by first name ascending
  I should see the following people in this order: 'Andy', 'Jared', 'Jeff', 'John', 'Rey', 'Wesley'


Scenario: sort the people by alphabetical first_name descending order
  When I follow "People"
  When I follow "First Name"
  When I follow "First Name"
  Then I should see the following people in this order: 'Wesley', 'Rey', 'John', 'Jeff', 'Jared', 'Andy'


Scenario: sort the people by alphabetical first_name ascending order
  When I follow "People"
  When I follow "First Name"
  Then I should see the following people in this order: 'Andy', 'Jared', 'Jeff', 'John', 'Rey', 'Wesley'


Scenario: sort the people by alphabetical last_name descending order
  When I follow "People"
  When I follow "Last Name"
  When I follow "Last Name"
  Then I should see the following people in this order: 'Zayas', 'To', 'Smith', 'Sanchez', 'Gunnison', 'Blume'


Scenario: sort the people by alphabetical last_name ascending order
  When I follow "People"
  When I follow "Last Name"
  Then I should see the following people in this order: 'Blume', 'Gunnison', 'Sanchez', 'Smith', 'To', 'Zayas'


Scenario: sort the people by progress descending order
  When I follow "People"
  When I follow "Progress"
  When I follow "Progress"
  Then I should see the following people in this order: 'Jared', 'Andy', 'Rey', 'Wesley', 'Jeff', 'John'


Scenario: sort the people by progress ascending order
  When I follow "People"
  When I follow "Progress"
  Then I should see the following people in this order: 'John', 'Wesley', 'Jeff', 'Rey', 'Jared', 'Andy'

