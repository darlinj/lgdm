class User < ActiveRecord::Base
  has_many :cloud_accounts
  has_many :chef_accounts
  acts_as_authentic do |c|
    c.login_field = :email
    c.maintain_sessions = false
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

  def create_chef_account(params)
    chef_accounts.create(params)
  end

  def cloud_images
    cloud.images
  end

  def cloud_servers
    cloud.servers
  end

  def start_server ami
    cloud.start_server(ami)
  end

  private
  def send_activation_email
    Activation.activate(self).deliver
  end

  def cloud
    @cloud ||= Cloud.new(cloud_accounts.first)
  end

end
