require 'spec_helper'

describe Cloud, "images" do
  before do
    Fog.mock!
    @cloud_account = Factory(:cloud_account, :region=>"pi-baynard-stable")

    bt = Fog::Compute.new(:provider => 'BT',
                          :region =>"pi-baynard-stable",
                          :bt_access_key_id => @cloud_account.ec2_access_key,
                          :bt_secret_access_key => @cloud_account.ec2_secret_key)
    images = {
      'imageSet' =>
      {
        'id'=>"pri-ed1a8d0b",
        'architecture'=>"x86_64",
        'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml",
        'owner_id'=>"joey",
        'state'=>"AVAILABLE",
        'type'=>"MACHINE",
        'is_public'=>true,
        'kernel_id'=>nil,
        'platform'=>"linux",
        'ramdisk_id'=>nil
      },
        'aaa-notamachine' =>
      {
        'id'=>"aaa-notamachine",
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
        'bibbleet2' =>
      { 'id'=>"pri-22222222",
        'architecture'=>"x86_64",
        'location'=>"cloudfs/initrd-2.6.18-194.8.1.el5xen.img.manifest.xml",
        'owner_id'=>"joey",
        'state'=>"AVAILABLE",
        'type'=>"MACHINE",
        'is_public'=>true,
        'kernel_id'=>nil,
        'platform'=>"linux",
        'ramdisk_id'=>nil
      }
    }
    Fog::BT::Compute::Mock.data["pi-baynard-stable"][@cloud_account.ec2_access_key][:images] = images
  end

  def do_request
    Cloud.new(@cloud_account).images
  end

  it 'should return an array of images' do
    do_request.sort { |a,b| a.id <=> b.id}[0].id.should == "pri-22222222"
    do_request.sort { |a,b| a.id <=> b.id}[1].id.should == "pri-ed1a8d0b"
  end
end

describe Cloud, "servers" do
  before do
    Fog.mock!
    compute = Cloud.new({:provider => "BT",:region => "pi-baynard-stable",
                        :bt_access_key_id => "some_access_key",
                        :bt_secret_access_key => "bibble"})
    compute.servers.create(:image_id => "AMI-123456", :key_name=>"foo")
    compute.servers.create(:image_id => "AMI-654321", :key_name=>"foo")
  end

  def do_request
    Cloud.new({:provider => "BT",:region => "pi-baynard-stable",
              :bt_access_key_id => "some_access_key",
              :bt_secret_access_key => "bibble"}).servers
  end

  it 'should return an array of servers' do
    servers = do_request.sort{|a,b| a.image_id <=> b.image_id}
    servers.first.image_id.should == "AMI-123456"
    servers.last.image_id.should == "AMI-654321"
  end
end

describe Cloud, "start_server" do
  before do
    Fog.mock!
    @compute = Cloud.new({:provider => "BT",:region => "some-region",
                         :bt_access_key_id => "some_access_key",
                         :bt_secret_access_key => "bibble"})
  end

  def do_request
    @compute.start_server("AMI12345")
  end

  it 'should return an array of servers' do
    do_request
    @compute.servers.first.image_id.should == "AMI12345"
  end
end
