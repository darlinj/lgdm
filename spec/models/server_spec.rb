require 'spec_helper'

describe Server, "all" do

  before do
    cloud_server1 = mock(Fog::Compute::Server, :id => "i-123456",
                        :dns_name     => "",
                        :image_id     => "",
                        :key_name     => "",
                        :groups       => [""],
                        :state        => ""
                        )
    cloud_server2 = mock(Fog::Compute::Server, :id => "i-654321",
                        :dns_name     => "",
                        :image_id     => "",
                        :key_name     => "",
                        :groups       => [""],
                        :state        => ""
                        )
    @cloud_servers = [cloud_server1,cloud_server2]
    @cloud = mock(Cloud, :servers=>@cloud_servers)
    @chef = nil
  end

  def do_request
    Server.all(@cloud, @chef)
  end

  it "should return a list of servers" do
    do_request.map{|i| i.id}.should include "i-123456"
    do_request.map{|i| i.id}.should include "i-654321"
  end

  context "there is a chef account" do
    before do
      @roles_array1=["role1", "role2"]
      @roles_array2=["role3"]
      @chef = mock(ChefApi)
      @chef.stub(:roles_for_server).with("i-123456").and_return(@roles_array1)
      @chef.stub(:roles_for_server).with("i-654321").and_return(@roles_array2)
    end

    it "should get the list of roles for the servers" do
      @chef.should_receive(:roles_for_server).with("i-123456")
      @chef.should_receive(:roles_for_server).with("i-654321")
      do_request
    end

    it "should merge the role info with the server info" do
      do_request.map{|i| i.roles}.should include @roles_array1
      do_request.map{|i| i.roles}.should include @roles_array2
    end
  end

end
