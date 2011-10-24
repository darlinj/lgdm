FactoryGirl.define do
  factory :cloud_account do |cloud_account|
    cloud_account.label           "Some cloud"
    cloud_account.provider        "BT"
    cloud_account.region          "somewhere"
    cloud_account.ec2_url         "http://foobar.thing.com"
    cloud_account.ec2_secret_key  "blahblahblahblahblahblahblahblahblahblah"
    cloud_account.ec2_access_key  "blahblahblahblahblahblahblahblahblahblah"
  end
end

