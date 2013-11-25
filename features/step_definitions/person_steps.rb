Given /the following people exist/ do |people_table|
  people_table.hashes.each do |person|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that person to the database here.
    Person.create!(:first_name => person[:first_name], :last_name => person[:last_name], :progress => person[:progress], :favorite => person[:favorite])
  end
end

Then /I should see '(.*)' before '(.*)'/ do |e1, e2|
	body = page.find('#body').text
	body.index(e1).should < body.index(e2)
end

Then /^I should see the following people in this order: (.*)/ do |people_list|
	sorted_people = []
	people_list.split(', ').each do |person|
		sorted_people.push(person)
	end
	sorted_people.each_cons(2) do |a, b|
		step %{I should see #{a} before #{b}}
	end
end



