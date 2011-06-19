require 'spec_helper'

describe ImagesController, "index" do
  before do
    credentials = {:provider => "BT",
                   :region => "middle",
                   :bt_access_key_id => "some_id",
                   :bt_secret_access_key => "some_key"}
    cloud = mock Cloud
    Cloud.stub(:new).with(credentials).and_return(cloud)
    cloud.stub(:images).and_return(:some_images)
  end

  def do_request
    get :index
  end

  subject { do_request; @controller                                       }
    it    { should assign_to(:images).with(:some_images) }
    it    { should render_template(:index)                                }
end


