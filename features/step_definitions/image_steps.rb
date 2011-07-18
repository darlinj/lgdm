Given %r/^there are server images available$/ do

  bt = Fog::Compute.new(:provider => 'BT',
                        :region =>"pi-baynard-stable",
                        :bt_access_key_id => Rails.application.config.bt_access_key_id,
                        :bt_secret_access_key => Rails.application.config.bt_secret_access_key)

  bt.images
  Fog::BT::Compute::Mock.data["pi-baynard-stable"].first.last[:images] = {'imageSet' => { 'id'=>"pri-ed1a8d0b", 'architecture'=>"x86_64", 'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml", 'owner_id'=>"joey", 'state'=>"AVAILABLE", 'type'=>"RAMDISK", 'is_public'=>true, 'kernel_id'=>nil, 'platform'=>"linux", 'ramdisk_id'=>nil }, 'bibbleet2' => { 'id'=>"pri-22222222", 'architecture'=>"x86_64", 'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml", 'owner_id'=>"joey", 'state'=>"AVAILABLE", 'type'=>"RAMDISK", 'is_public'=>true, 'kernel_id'=>nil, 'platform'=>"linux", 'ramdisk_id'=>nil } }

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

When %r/^I click the server start button for a particular image$/ do
  within(:css, "tr#pri-22222222") do
    click_link("run")
  end
end


