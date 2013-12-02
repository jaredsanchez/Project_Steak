Then /^I should see the all of the following: (.*)/ do |items_list|
	people_list.split(', ').each do |item|
		step %{I should see "#{item}"}
	end
end

Then /^I should not see the all of the following: (.*)/ do |items_list|
	people_list.split(', ').each do |item|
		step %{I should not see "#{item}"}
	end
end


