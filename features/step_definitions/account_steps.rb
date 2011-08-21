Given %r/^there are some accounts$/ do
  user = User.find_by_email("fred.flintstone@bedrock.com")
  CloudAccount.create(:label          => 'cloud1',
                      :provider       => 'BT',
                      :region         => 'bellybutton',
                      :s3_url         => 'http://storage.fr002.baynard.cloud21cn.com:8080',
                      :ec2_url        => 'http://api.fr002.baynard.cloud21cn.com:8773',
                      :ec2_access_key => 'blahblahblahblahblahblahblah',
                      :ec2_secret_key => 'blahblahblahblahblahblahblah',
                      :user_id        => user.id )

  CloudAccount.create(:label          => 'cloud2',
                      :provider       => 'BT',
                      :region         => 'bellybutton',
                      :s3_url         => 'http://storage.fr002.baynard.cloud21cn.com:8080',
                      :ec2_url        => 'http://api.fr002.baynard.cloud21cn.com:8773',
                      :ec2_access_key => 'blahblahblahblahblahblahblah',
                      :ec2_secret_key => 'blahblahblahblahblahblahblah',
                      :user_id        => user.id )
end

When %r/^I go to the accounts page$/ do
  visit('/cloud_accounts')
end

Then %r/^I should see that there are some accounts$/ do
  page.should have_content('cloud1')
  page.should have_content('cloud2')
end

When %r/^I go to the new account page$/ do
  visit('/cloud_accounts/new')
end

When %r/^I fill in valid account details$/ do
  fill_in("Label", :with => "cloudy cloud")
  fill_in("Provider", :with => "BT")
  fill_in("Region", :with => "East Indies")
  fill_in("S3 url", :with => "http://some.address:999/foo")
  fill_in("Ec2 url", :with => "http://some.address:999/foo")
  fill_in("Ec2 access key", :with => "blahblahblahblahblahblahblah")
  fill_in("Ec2 secret key", :with => "blahblahblahblahblahblahblah")
  click_button("Create")
end

Then %r/^I should see that there is a new account$/ do
  page.current_path.should == cloud_accounts_path
  page.should have_content('cloudy cloud')
end

When %r/^I fill in INVALID account details$/ do
  fill_in("Label", :with => "")
  fill_in("Provider", :with => "BT")
  fill_in("Region", :with => "East Indies")
  fill_in("S3 url", :with => "http://some.address:999/foo")
  fill_in("Ec2 url", :with => "http://some.address:999/foo")
  fill_in("Ec2 access key", :with => "blahblahblahblahblahblahblah")
  fill_in("Ec2 secret key", :with => "blahblahblahblahblahblahblah")
  click_button("Create")
end

Then %r/^I should see that the create has failed$/ do
  page.should have_content('unsuccessful')
end

