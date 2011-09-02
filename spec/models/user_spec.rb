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

describe User, "activate!" do
  before do
    @user = User.create!(:email => "something.that@lookslike.an.email.com", :password => "secret", :password_confirmation => "secret")
    UserSession.stub(:create!)
  end

  it "should set the active column to true" do
    @user.active.should be_false
    @user.activate!
    @user.active.should be_true
  end

  it "should sign the user in" do
    UserSession.should_receive(:create!).with(@user)
    @user.activate!
  end
end

describe User, "create_cloud_account" do
  before do
    @user = User.create!(:email => "something.that@lookslike.an.email.com", :password => "secret", :password_confirmation => "secret")
    @params = {"label"          =>"my_account",
               "provider"       =>"FOOO",
               "region"         =>"somewhere",
               "s3_url"         =>"http://some.address:999/foo",
               "ec2_url"        =>"http://some.address:999/foo",
               "ec2_access_key" =>"blahblahblahblahblahblahblah",
               "ec2_secret_key" =>"blahblahblahblahblahblahblah"
    }
  end

  def do_request
    @user.create_cloud_account(@params)
    CloudAccount.find_by_label("my_account")
  end

  it "should create an account with the params supplied" do
    do_request.provider.should == "FOOO"
  end

  it "should set the user association" do
    cloud_account = do_request
    @user.cloud_accounts.should include(cloud_account)
  end
end

describe User, "create_chef_account" do
  before do
    @user = User.create!(:email => "something.that@lookslike.an.email.com", :password => "secret", :password_confirmation => "secret")
    @params = {"label"          =>"my_account",
               "chef_server_url" =>"http://doo.bar.com",
               "chef_server_key" =>"blah blah",
    }
  end

  def do_request
    @user.create_chef_account(@params)
    ChefAccount.find_by_label("my_account")
  end

  it "should create an account with the params supplied" do
    do_request.label.should == "my_account"
  end

  it "should set the user association" do
    chef_account = do_request
    @user.chef_accounts.should include(chef_account)
  end
end

describe User, "cloud_images" do

  before do
    @user = Factory(:user)
    @cloud_account = Factory(:cloud_account, :user_id => @user.id)
    cloud = mock(Cloud, :images=>:some_images)
    Cloud.stub(:new).and_return(cloud)
  end

  def do_request
    @user.cloud_images
  end

  it "should query a cloud" do
    Cloud.should_receive(:new).with(@cloud_account)
    do_request
  end

  it "should return a list of images" do
    do_request.should == :some_images
  end

end

describe User, "cloud_servers" do

  before do
    @user = Factory(:user)
    @cloud_account = Factory(:cloud_account, :user_id => @user.id)
    cloud = mock(Cloud, :servers=>:some_servers)
    Cloud.stub(:new).and_return(cloud)
  end

  def do_request
    @user.cloud_servers
  end

  it "should query a cloud" do
    Cloud.should_receive(:new).with(@cloud_account)
    do_request
  end

  it "should return a list of servers" do
    do_request.should == :some_servers
  end

end

describe User, "running a server" do

  before do
    @user = Factory(:user)
    @cloud_account = Factory(:cloud_account, :user_id => @user.id)
    @cloud = mock(Cloud)
    Cloud.stub(:new).and_return(@cloud)
  end

  def do_request
    @user.start_server(:some_ami)
  end

  it "should request the cloud to run the server" do
    @cloud.should_receive(:start_server).with(:some_ami)
    do_request
  end

end
