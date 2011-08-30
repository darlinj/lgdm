Given %r/^there are server images available$/ do
  cloud_account = Factory(:cloud_account, :region=>"pi-baynard-stable", :user_id => @current_user.id)

  bt = Fog::Compute.new(:provider => 'BT',
                        :region =>"pi-baynard-stable",
                        :bt_access_key_id => cloud_account.ec2_access_key,
                        :bt_secret_access_key => cloud_account.ec2_secret_key)

  bt.images
  Fog::BT::Compute::Mock.data["pi-baynard-stable"].first.last[:images] = {
    'imageSet' => { 'id'=>"pri-ed1a8d0b",
      'architecture'=>"x86_64",
      'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml",
      'owner_id'=>"joey",
      'state'=>"AVAILABLE",
      'type'=>"MACHINE",
      'is_public'=>true, #
      'kernel_id'=>nil,
      'platform'=>"linux",
      'ramdisk_id'=>nil },
    'pri-notamach' => { 'id'=>"pri-notamach",
      'architecture'=>"x86_64",
      'location'=>"notamachine/manifest.xml",
      'owner_id'=>"foo",
      'state'=>"AVAILABLE",
      'type'=>"RAMDISK",
      'is_public'=>true, #
      'kernel_id'=>nil,
      'platform'=>"linux",
      'ramdisk_id'=>nil },
    'bibbleet2' => { 'id'=>"pri-22222222",
      'architecture'=>"x86_64",
      'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml",
      'owner_id'=>"joey",
      'state'=>"AVAILABLE",
      'type'=>"MACHINE",
      'is_public'=>true,
      'kernel_id'=>nil,
      'platform'=>"linux",
      'ramdisk_id'=>nil } 
  }

end

When %r/^I go to the list of images$/ do
  visit(path_to("image list"))
end

Then %r/^I should see the list of images$/ do
  within("table") do
    page.should have_content("pri-22222222")
    page.should have_content("pri-ed1a8d0b")
  end
end

Then %r/^I should not see images that are not machines$/ do
  within("table") do
    page.should_not have_content("pri-notamach")
  end
end

When %r/^I click the server start button for a particular image$/ do
  within(:css, "tr#pri-22222222") do
    click_link("run")
  end
end

Then %r/^I should be on the images page$/ do
  page.current_path.should == images_path
end

