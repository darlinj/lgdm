class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  #disable_perishable_token_maintenance(true)

  after_create :send_activation_email

  def activate!
    self.active = true
    save
  end

  private
  def send_activation_email
    Activation.activate(self).deliver
  end
end
