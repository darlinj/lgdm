require 'spec_helper'

describe ChefApi, "roles_for_server" do
  before do
    @chef = ChefApi.new(Factory(:chef_api_account))
  end

  it "should get the roles for the server supplied" do
    VCR.use_cassette("get_server_info") do
      @chef.roles_for_server("i-000CCfD1").should == ["some_role"]
    end
  end

  it "should return an empty array when there is no corresponding record on chef" do
    VCR.use_cassette("node_404") do
      @chef.roles_for_server("i-000DDfD1").should == []
    end
  end

  it "should return an empty array when a node is returned with no roles" do
    VCR.use_cassette("node_roles_no_role") do
      @chef.roles_for_server("i-000CiS92").should == []
    end
  end
end

