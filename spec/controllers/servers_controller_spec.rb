require 'spec_helper'

describe ServersController, "create" do
  before do
    credentials = { :provider => Rails.application.config.provider,
                    :region => Rails.application.config.region,
                    :bt_access_key_id => Rails.application.config.bt_access_key_id,
                    :bt_secret_access_key => Rails.application.config.bt_secret_access_key }
    @cloud = mock Cloud
    Cloud.stub(:new).with(credentials).and_return(@cloud)
    @cloud.stub(:run_image).and_return(true)
    @image_id = "ami12345"
  end

  def do_request
    post :create, :image_id => @image_id
  end

  it "should create the server on the cloud" do
    @cloud.should_receive(:run_image).with(@image_id)
    do_request
  end

  subject { do_request; @controller    }
    it    { should redirect_to(:servers) }
end

describe ServersController, "index" do
  before do
    credentials = { :provider => Rails.application.config.provider,
                    :region => Rails.application.config.region,
                    :bt_access_key_id => Rails.application.config.bt_access_key_id,
                    :bt_secret_access_key => Rails.application.config.bt_secret_access_key }
    cloud = mock Cloud
    Cloud.stub(:new).with(credentials).and_return(cloud)
    cloud.stub(:servers).and_return(:some_servers)
  end

  def do_request
    get :index
  end

  subject { do_request; @controller    }
    it    { should assign_to(:servers).with(:some_servers) }
    it    { should render_template(:index)                          }
end

