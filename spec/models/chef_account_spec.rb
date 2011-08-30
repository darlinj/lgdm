require 'spec_helper'

describe ChefAccount, "validations" do
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:chef_server_url) }
  it { should validate_presence_of(:chef_server_key) }
end
