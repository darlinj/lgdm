require 'spec_helper'

describe Cloud, "images" do
  before do
    Fog.mock!

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

  def do_request
    Cloud.images
  end

  it 'should return an array of images' do
    do_request.sort { |a,b| a.id <=> b.id}[0].id.should == "pri-22222222"
    do_request.sort { |a,b| a.id <=> b.id}[1].id.should == "pri-ed1a8d0b"
  end

end


