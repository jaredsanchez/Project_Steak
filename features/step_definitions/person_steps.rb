Given /the following people exist/ do |people_table|
  people_table.hashes.each do |person|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that person to the database here.
    Person.create!(:first_name => person[:first_name], 
	:last_name => person[:last_name], 
	:progress => person[:progress], 
	:favorite => person[:favorite], 
	:email => person[:email],
	:hr_dept_name => person[:hr_dept_name], 
	:building => person[:building], 
	:room_number => person[:room_number], )
  end
end

Given /^the group named "(.*?)" exists with the following people:$/ do |group_name, people|
	puts page.body
	group = Group.create!(:name => group_name, :description => "Default")
	people.hashes.each do |person|
		current = Person.find_by_last_name person["last_name"]
		group.people << current
	end
	group.save
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



