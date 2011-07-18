class User < ActiveRecord::Base
  acts_as_authentic
  after_create :send_activation_email


  private

  def send_activation_email
    Activation.activate(self).deliver
  end
end
