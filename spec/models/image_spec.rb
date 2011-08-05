require 'spec_helper'

describe Image, "all" do
  before do
    Cloud.stub(:images).and_return(:some_images)
  end

  it 'should return an array of images' do
    Image.all.should == :some_images
  end

end


