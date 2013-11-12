When(/^I select date "(.*?)" from "(.*?)"$/) do |date, label|
 # select_date("Event Date", :with => "2013-02-03")
end

Given /the following events exist/ do |event_table|
  event_table.hashes.each do |event|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that person to the database here.
    Event.create!(event)
  end
end
    
