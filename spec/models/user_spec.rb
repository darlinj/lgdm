require 'spec_helper'

describe User, "create" do
  let(:email) { mock(Activation, :deliver => true) }

  before do
     @user = User.new :email => "something.that@lookslike.an.email.com", :password => "secret", :password_confirmation => "secret"
    Activation.stub(:activate).and_return(email)
  end

  def do_request
     @user.save
  end

  it 'should send an email' do
    Activation.should_receive(:activate).with(@user)
    email.should_receive(:deliver)
    do_request
  end

end


