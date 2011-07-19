Given %r/^there is a user$/ do
  User.create!(:email => "fred.flintstone@bt.com",
               :password => "secret",
               :password_confirmation => "secret")
end

When %r/^I go to the login form$/ do
  visit(path_to("login"))
end

