class SplitName < ActiveRecord::Migration
	people = Person.all
	people.each do |person|
		n = person.name.split
		person.first_name = n[0]
		person.last_name = n[1]
	end
end
