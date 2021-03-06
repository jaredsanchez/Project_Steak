Then /^I should see all of the following: (.*)$/ do |items_list|
	items_list.split(', ').each do |item|
		step %{I should see #{item}}
	end
end

Then /^I should not see all of the following: (.*)$/ do |items_list|
	items_list.split(', ').each do |item|
		step %{I should not see #{item}}
	end
end

