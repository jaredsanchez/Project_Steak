Feature: display list of people involved in an intiative
 
  As an influencer
  so I can know who is involved
  I want to see who is working on a given initiative when I view it 

Background: movies have been added to database
  
  Given the following people exist:
  | first_name    | last_name | progress | favorite |
  | John          | Gunnison  | 1        | true     |
  | Jeff          | Zayas     | 2        | true     |
  | Rey           | Blume     | 3        | true     |
  | Jared         | Sanchez   | 4        | false    |
  | Wesley        | To        | 2        | false    |
  | Andy          | Smith     | 4        | false    |

  And I am on the StakeHolder Mapping home page

Scenario: display list of people involved in initiative
  Then I should see "John Gunnison"
  Then I should see "Jeff Zayas"
  Then I should see "Rey Blume"
  Then I should see "Jared Sanchez"
  Then I should see "Wesley To"
  Then I should see "Andy Smith"


