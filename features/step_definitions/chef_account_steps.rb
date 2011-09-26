Given %r/^there are some chef accounts$/ do
  user = User.find_by_email("fred.flintstone@bedrock.com")
  Factory.create(:chef_api_account, :label => 'chef account one',:user_id=>user.id)
  Factory.create(:chef_api_account, :label => 'A chef account',:user_id=>user.id)
end

When %r/^I go to the chef accounts page$/ do
  visit('/chef_api_accounts')
end

Then %r/^I should see that there are some chef accounts$/ do
  page.should have_content('chef account one')
  page.should have_content('A chef account')
end

When %r/^I go to the new chef account page$/ do
  visit('/chef_api_accounts/new')
end

When %r/^I fill in valid chef account details$/ do
  fill_in("Label", :with => "chef cloud")
  fill_in("Chef server url", :with => "http:\\blah.com")
  fill_in("Chef username",   :with => "Bob")
  fill_in("Chef server key", :with => "blah blah")
  click_button("Create")
end

Then %r/^I should see that there is a new chef account$/ do
  page.current_path.should == chef_api_accounts_path
  page.should have_content('chef cloud')
end

When %r/^I fill in INVALID chef account details$/ do
  fill_in("Label", :with => "")
  click_button("Create")
end


