Given %r/^there is a user$/ do
  @current_user = User.create!(:email => "fred.flintstone@bedrock.com",
               :password => "secret",
               :password_confirmation => "secret",
               :active => true )
end

When %r/^I go to the login form$/ do
  visit(path_to("login"))
end

