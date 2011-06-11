require 'spec_helper'

describe ImagesController, "index" do
  before do
    Image.stub(:all).and_return(:some_images)
  end

  def do_request
    get :index
  end

  subject { do_request; @controller                                       }
    it    { should assign_to(:images).with(:some_images) }
    it    { should render_template(:index)                                }
end


