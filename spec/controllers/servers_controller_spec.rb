require 'spec_helper'

describe ServersController, "create" do
  before do
  end

  def do_request
    post :create
  end

  #it "should create the server on the cloud" do
    #Cloud.should_receive(:run_image).with(@image_id)
  #end

  subject { do_request; @controller    }
    it    { should redirect_to(:servers) }
end

describe ServersController, "index" do
  before do
    Cloud.stub(:servers).and_return(:some_servers)
  end

  def do_request
    get :index
  end

  subject { do_request; @controller    }
    it    { should assign_to(:servers).with(:some_servers) }
    it    { should render_template(:index)                          }
end

