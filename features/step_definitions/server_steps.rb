When %r/^I go to the list of servers$/ do
  if @chef_account
    VCR.use_cassette('node_roles', :erb => {:chef_url => @chef_account.chef_server_url ,
                     :first_server_id => @server1.id,
                     :first_server_role => "a_chef_role",
                     :second_server_id => @server2.id,
                     :second_server_role => "another_chef_role",
                     :third_server_id => @server3.id}) do
      visit(path_to("server list"))
    end
  else
    visit(path_to("server list"))
  end
end

Then %r/^I should see that the server has been started$/ do
  within("table") do
    #save_and_open_page
    page.should have_content("pending")
    #should test that there is one more row in the table
  end
end

Given %r/^there are some servers on the cloud$/ do
  cloud_account = Factory(:cloud_account, :region=>"pi-baynard-stable", :user_id => @current_user.id)
  bt = Fog::Compute.new(:provider => 'BT',
                        :region =>"pi-baynard-stable",
                        :bt_access_key_id => cloud_account.ec2_access_key,
                        :bt_secret_access_key => cloud_account.ec2_secret_key)

  @server1 = bt.servers.create(:image_id => "pmi-123456")
  @server2 = bt.servers.create(:image_id => "pmi-654321")
  @server3 = bt.servers.create(:image_id => "pmi-654321")
end

Then %r/^I should see the servers$/ do
  within("table") do
    page.should have_content(@server1.id)
    page.should have_content(@server2.id)
    page.should have_content(@server3.id)
  end
end

Given %r/^there is a chef account$/ do
  @chef_account = Factory.create(:chef_api_account, :user_id => @current_user.id )
end

Then %r/^I should see that some servers have roles attached$/ do
  page.should have_content('a_chef_role')
  page.should have_content('another_chef_role')
end
