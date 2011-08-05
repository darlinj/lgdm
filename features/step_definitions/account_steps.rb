Given %r/^there are some accounts$/ do
  user = User.find_by_email("fred.flintstone@bedrock.com")
  CloudAccount.create(:label          => 'cloud1',
                      :provider       => 'BT',
                      :s3_url         => 'http://storage.fr002.baynard.cloud21cn.com:8080',
                      :ec2_url        => 'http://api.fr002.baynard.cloud21cn.com:8773',
                      :ec2_access_key => 'blahblahblahblahblahblahblah',
                      :ec2_secret_key => 'blahblahblahblahblahblahblah',
                      :user_id        => user.id )

  CloudAccount.create(:label          => 'cloud2',
                      :provider       => 'BT',
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

