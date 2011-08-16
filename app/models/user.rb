class User < ActiveRecord::Base
  has_many :cloud_accounts
  acts_as_authentic do |c|
    c.login_field = :email
  end


  after_create :send_activation_email

  def activate!
    self.active = true
    UserSession.create!(self)
    save
  end

  def create_cloud_account(params)
    cloud_accounts.create(params)
  end

  def cloud_images
    cloud_account = cloud_accounts.first
    cloud = Cloud.new( :provider => cloud_account.provider,
                       :region => cloud_account.region,
                       :bt_access_key_id => cloud_account.ec2_access_key,
                       :bt_secret_access_key => cloud_account.ec2_secret_key
    )
    cloud.images
  end

  private
  def send_activation_email
    Activation.activate(self).deliver
  end

end
