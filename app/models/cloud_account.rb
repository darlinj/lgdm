class CloudAccount < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :label
  validates_presence_of :provider
  validates_presence_of :ec2_url
  validates_presence_of :ec2_secret_key
  validates_presence_of :ec2_access_key

end
