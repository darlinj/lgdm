require 'spec_helper'

describe Image, "all" do
  before do
    Cloud.should_receive(:images).and_return(:some_images)
  end

  def do_request
    Image.all
  end

  it 'should return an array of images' do
    do_request.should == :some_images
  end

end


