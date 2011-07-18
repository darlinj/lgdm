require 'spec_helper'

describe UsersController, "create" do
  before do
    @user = mock(User, :save => true)
    User.stub(:new).and_return(@user)
  end

  def do_request
    post :create, :user => :params
  end

  it "should create and save the user" do
    User.should_receive(:new).with(:params)
    do_request
  end

  it "should save the user" do
    @user.should_receive(:save)
    do_request
  end

  context "successful login" do

    subject { do_request; @controller    }
      it    { should redirect_to(:root) }
      it    { should set_the_flash.to(/successful/) }
      it    { should set_the_flash.to(/receive an email/) }

  end

end
