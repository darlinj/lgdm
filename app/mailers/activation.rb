class Activation < ActionMailer::Base
  def activate user
    @user      = user
    mail( :to => user.email,
    :from => Rails.application.config.email_sender,
    :subject => "Welcome to the lean green deployment machine")
  end
end
