# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
end

Given /^I am on the Rotten Potatoes home page$/ do
  visit movies_path
 end

 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
   assert result
 end

Then /^I should see a movie list entry with title "(.*?)" and director  "(.*?)"$/ do |arg1, arg2|
  result=false
   all("tr").each do |tr|
     if tr.has_content?(arg1) && tr.has_content?(arg2)
       result = true
       break
     end
   end  
   assert result
end

Then /^I should see a movie list entry with title "(.*?)" and director "(.*?)"$/ do |arg1, arg2|
  result=false
   all("tr").each do |tr|
     if tr.has_content?(arg1) && tr.has_content?(arg2)
       result = true
       break
     end
   end  
   assert result
end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

Then /^(?:|I )should see "([^"]*)"$/ do |arg1|
  assert (page.body=~/.*?#{Regexp.escape(arg1)}.*?/m)
end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end

 When /^I have edited the movie "(.*?)" to change the director to "(.*?)"$/ do |movie, director|
  click_on "Edit"
  fill_in('director',:with=>director)
  click_button 'Update Movie Info'
 end

# New step definitions to be completed for HW3. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # You should arrange to add that movie to the database here.
    # You can add the entries directly to the databasse with ActiveRecord methodsQ
    Movie.create!(movie)
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
  arg1.split(',').each do |rating|
    check 'ratings_'+rating.strip
  end
  click_button('Refresh')
end


When /^I have opted to view movies by the same director$/ do
  click_on('Find Movies With Same Director')
end

When /^I have opted to view movies with the same director$/ do
  click_on('Find Movies With Same Director')
end


Then /^I should see only movies rated "(.*?)"$/ do |arg1|
  rating_hash={}
  arg1.split(',').each do |rating|
    find('table').should have_css('td', :text => rating)
    rating_hash[rating]=1
  end
  Movie.all_ratings.each do |rating|
    if !rating_hash.has_key?(rating)
      find('table').should have_no_css('tb', :text => rating)
    end
  end
end

Then /^I should see all of the movies$/ do
  rows=0
  find('table').find('tbody').all('tr').each do |tr|
   rows+=1
  end
  rows.should == Movie.all.count 
end

When /^I have sorted the movies by title$/ do
  click_on "title_header"
end

When /^I have sorted the movies by release date$/ do
  click_on "release_date_header"
end

Then /^I should see "(.*?)" before "(.*?)"$/ do |movie1,movie2|
  assert page.body=~/.*?#{Regexp.escape(movie1)}.*?#{Regexp.escape(movie2)}.*?/m
end

Then /^I should not see a movie list entry with title  "(.*?)" and director "(.*?)"$/ do |arg1, arg2|
  assert !(page.body=~/.*?#{Regexp.escape(arg1)}.*?/m||page.body=~/.*?#{Regexp.escape(arg2)}.*?/m)
end

Then /^I should not see "(.*?)"$/ do |arg1|
  assert !(page.body=~/.*?#{Regexp.escape(arg1)}.*?/m)
end


