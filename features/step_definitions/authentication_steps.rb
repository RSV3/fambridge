Given /^a user visits the signin page$/ do
  visit signin_path 
end

When /^they submit an invalid signin information$/ do
  click_button "Sign in"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-danger')
end

Given(/^the user has an account$/) do
  @user = User.create(first_name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar") 
end

When(/^the user submits a valid signin information$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in" 
end

Then(/^they should see their profile$/) do
  expect(page).to have_title(@user.first_name)
end

Then(/^they should see a signout link$/) do
  expect(page).to have_link("Sign out", href: signout_path)
end
