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

