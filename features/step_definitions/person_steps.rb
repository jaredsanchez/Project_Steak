Given /the following people exist/ do |people_table|
  people_table.hashes.each do |person|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that person to the database here.
    Person.create!(:name => person[:name], :progress => person[:progress])
  end
end
