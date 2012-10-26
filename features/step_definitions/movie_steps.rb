# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
#flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#puts "#{e1}.+#{e2}"
#puts page.body =~ /#{e1}.*+{e2}/m
  assert(page.body =~ /#{e1}.*#{e2}/m, "wrong order")
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
#flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |box|
    field_name = "ratings_#{box.strip}"
    if uncheck
      uncheck(field_name)
    else
      check(field_name)
    end
  end
end

Then /I should see the following ratings checked: (.*)/ do |rating_list|
  rating_list.split(',').each do |box|
    box_checked = find_field("ratings_#{box.strip}")['checked']
    if box_checked.respond_to? :should
      box_checked.should be_true
    else
      assert box_checked
    end

  end
end
Then /I should see all the movies/ do ||
  puts all("tr").count
  all("tr").count == 10
end
