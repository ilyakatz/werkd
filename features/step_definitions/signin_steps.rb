Given /^I am a new, authenticated user$/ do
  password = 'secretpass'
  user = Factory.create(:user, password: password, password_confirmation: password)

  visit new_user_session_path
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.password
  click_button "Sign in"
end

Given /^I am a new, authenticated user with email "(.*?)"$/ do |email|
  password = 'secretpass'
  user = Factory.create(:user, password: password, password_confirmation: password, email: email)

  visit new_user_session_path
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.password
  click_button "Sign in"
end


Given /^I am not signed in$/ do
  page.driver.submit :delete, destroy_user_session_path, {}
end
