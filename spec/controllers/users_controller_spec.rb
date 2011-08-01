require 'spec_helper'

describe UsersController, "new" do
  before do
    User.stub(:new).and_return(:some_user)
  end

  def do_request
    get :new
  end

  subject { do_request; @controller                  }
    it    { should assign_to(:user).with(:some_user) }
    it    { should render_template(:new)             }
end

describe UsersController, "create" do
  before do
    @user = mock(User, :save => true, :activate! => true)
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

describe UsersController, "update" do
  before do
    @user = mock(User, :activate! => true)
    User.stub(:find_by_perishable_token).and_return(@user)
  end

  def do_request
    get :update, :token => :some_token
  end

  context "successful activation" do

    it "should find the user with the perishable token" do
      User.should_receive(:find_by_perishable_token).with(:some_token)
      do_request
    end

    it "should activate the user" do
      @user.should_receive(:activate!)
      do_request
    end

    subject { do_request; @controller    }
    it    { should redirect_to(:root) }
    it    { should set_the_flash.to(/Activation/) }
  end
end
