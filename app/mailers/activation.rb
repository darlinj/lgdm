class Activation < ActionMailer::Base
  def activate user
    recipients user.email
    from       Rails.application.config.email_sender
    subject    "Welcome to the lean green deployment machine"
    @user      = user
  end
end
