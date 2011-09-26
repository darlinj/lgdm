require 'spec_helper'

describe ChefApiAccount, "validations" do
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:chef_server_url) }
  it { should validate_presence_of(:chef_server_key) }
  it { should validate_presence_of(:chef_username) }
end
