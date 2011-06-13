Given %r/^there are server images available$/ do

  @images = {'imageSet' => {
    'id'=>"pri-ed1a8d0b",
    'architecture'=>"x86_64",
    'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml",
    'owner_id'=>"joey",
    'state'=>"AVAILABLE",
    'type'=>"RAMDISK",
    'is_public'=>true,
    'kernel_id'=>nil,
    'platform'=>"linux",
    'ramdisk_id'=>nil
  },
    'bibbleet2' => {
    'id'=>"pri-22222222",
    'architecture'=>"x86_64",
    'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml",
    'owner_id'=>"joey",
    'state'=>"AVAILABLE",
    'type'=>"RAMDISK",
    'is_public'=>true,
    'kernel_id'=>nil,
    'platform'=>"linux",
    'ramdisk_id'=>nil
  }
  }

  Cloud.set_mock_images(@images)

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

