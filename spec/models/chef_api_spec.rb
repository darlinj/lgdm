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

end