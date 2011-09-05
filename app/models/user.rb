class User < ActiveRecord::Base
  has_many :cloud_accounts
  has_many :chef_api_accounts
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
    chef_api_accounts.create(params)
  end

  def cloud_images
    cloud.images
  end

  def cloud_servers
    Server.all(cloud, chef)
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

  def chef
    return nil if chef_api_accounts.empty?
    @chef ||= ChefApi.new(chef_api_accounts.first)
  end
end
