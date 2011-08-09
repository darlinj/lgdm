require 'spec_helper'

describe CloudAccount, "validations" do
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:ec2_url) }
  it { should validate_presence_of(:ec2_access_key) }
  it { should validate_presence_of(:ec2_secret_key) }
end
