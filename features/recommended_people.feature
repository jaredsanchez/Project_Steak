Feature: show a list of recommended people to add to an event 
 
	As an influencer
	So that I can easily decide who I should add to an event
	I want to see a list of 10 recommended people to add to an event

Background: Start on the home page
  Given I am on the home page
  Then I should see "Sign In"
  When I follow "Sign In"
  And I conditionally fill in "Email" with "projectsteak@gmail.com"
  And I conditionally fill in "Passwd" with "steak222"
  Then I conditionally press "Sign in"
  Then I conditionally press "Accept"
  Given the following people exist:
  | first_name    | last_name | progress | favorite | org  | building | room |
  | John          | Gunnison  | 1        | true     | EECS | Soda     | 1    |
  | Jeff          | Zayas     | 2        | true     | EECS | Soda     | 10   |
  | Rey           | Blume     | 3        | true     | EECS | Cory     | 2120 |
  | Jared         | Sanchez   | 4        | false    | LSCS | Soda     | 615  |
  | Wesley        | To        | 2        | false    | LSCS | Cory     | 1610 |
  | Andy          | Smith     | 4        | false    | MATH | Evans    | 80   |
  | Homer         | Simpson   | 1        | true     | EECS | Soda     | 2    |
  | Marge         | Bouvier   | 2        | true     | EECS | Soda     | 11   |
  | Phillip       | Fry       | 3        | true     | EECS | Cory     | 2121 |
  | Turanga       | Leela     | 4        | false    | LSCS | Soda     | 616  |
  | John          | Zoidberg  | 2        | false    | LSCS | Cory     | 1611 |
  | Bender        | Rodriguez | 4        | false    | MECH | Evans    | 81   |
  | Amy           | Wong      | 1        | true     | EECS | Soda     | 3    |
  | Zapp          | Brannigan | 2        | true     | EECS | Soda     | 12   |
  | Kif           | Kroker    | 3        | true     | EECS | Cory     | 2122 |
  | Bumblebee     | Man       | 4        | false    | LSCS | Soda     | 617  |
  | Troy          | McClure   | 2        | false    | LSCS | Cory     | 1612 |
  | Herbert       | Powell    | 4        | false    | MECH | Evans    | 82   |
  | Herschel      | Krustofski| 1        | true     | EECS | Soda     | 4    |
  | Lyle          | Lanley    | 2        | true     | EECS | Soda     | 13   |
  | Hans          | Moleman   | 3        | true     | EECS | Cory     | 2123 |
  | Charles       | Burns     | 4        | false    | LSCS | Soda     | 618  |
  | Waylon        | Smithers  | 2        | false    | LSCS | Cory     | 1613 |
  | Abraham       | Simpson   | 4        | false    | MECH | Evans    | 83   |

  And I am on the StakeHolder Mapping home page

@javascript
Scenario: add an event and a person and see a list of 10 recommended people
  When I first hover over "Events" and then follow "Add Event"
  Then I should be on the Add Event page
  When I fill in "Name" with "Stakeholder Dinner"
  And I fill in "Description" with "A dinner for stake holders"
  And I fill in "Location" with "Cheeseboard"
  And I press "Add"
  And I fill in "Name" with "John Gunnison"
  And I press "Add"
  Then I should be redirected to the event page for "Stakeholder Dinner"
  And I should see "John Gunnison"
  And I should all of the following within "Recommendations": "Jeff", "Homer", "Marge", "Amy", "Zapp", "Herschel", "Lyle", "Jared", "Turanga", "Bumblebee"
