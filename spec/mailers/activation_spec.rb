require "spec_helper"

describe Activation, "activate" do

  let (:user) { User.create(:email => "something.that@email.com", 
                            :password => "secret", 
                            :password_confirmation => "secret") }

  it "should set the FROM address" do
    email = Activation.activate(user)
    email.from.should include(Rails.application.config.email_sender)
  end

  it "should set the TO address" do
    email = Activation.activate(user)
    email.to.should include(user.email)
  end

  it "should set the subject" do
    email = Activation.activate(user)
    email.subject.should == "Welcome to the lean green deployment machine"
  end
end
