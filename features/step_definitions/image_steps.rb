Given %r/^there are server images available$/ do

  images = {
    'image1' => {
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
    'image2' => {
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

  Fog::BT::Compute::Mock.data[:images] = images

  @bt.instance_variable_set(:@data, Fog::BT::Compute::Mock.data)

end

When %r/^I go to the list of images$/ do
  visit(path_to("image list"))
end
