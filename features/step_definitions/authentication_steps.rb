Given %r/^I am logged in$/ do
  User.create!(:email => "fred.flintstone@bedrock.com", :password => "secret", :password_confirmation => "secret", :active => true)
  visit(path_to("login"))
  fill_in("Email", :with => "fred.flintstone@bedrock.com")
  fill_in("Password", :with => "secret")
  click_button("Log in")
end

When %r/^I go to the sign\-up form$/ do
  visit(path_to("signup page"))
end

When %r/^I fill in valid user details$/ do
  fill_in("Email", :with => "fred.flintstone@bedrock.com")
  fill_in("Password", :with => "secret")
  fill_in("Password confirmation", :with => "secret")
  click_button("Register")
end

When %r/^I should get an email$/ do
  open_email("fred.flintstone@bedrock.com").should have_subject(/Welcome/)
end

When %r/^I click on the link in the email$/ do
  click_first_link_in_email
end

Then %r/^I should be registered$/ do
  page.should have_content("Activation successful")
end

When %r/^I fill in valid login details$/ do
  fill_in("Email", :with => "fred.flintstone@bedrock.com")
  fill_in("Password", :with => "secret")
  click_button("Log in")
end

Then %r/^I should be logged in$/ do
  page.should have_content("Log out")
  page.should have_content("fred.flintstone@bedrock.com")
end

Then %r/^I should be on the sign in page$/ do
  page.should have_content("Login")
end

