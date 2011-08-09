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

  private
  def send_activation_email
    Activation.activate(self).deliver
  end
end
