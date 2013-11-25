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

    

Then /^I should see the following events in this order: (.*)/ do |events_list|
	sorted_events = []
	events_list.split(', ').each do |event|
		sorted_events.push(event)
	end
	sorted_events.each_cons(2) do |a, b|
		step %{I should see #{a} before #{b}}
	end
end
