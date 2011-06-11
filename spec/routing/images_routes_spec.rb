require 'spec_helper'

describe ImagesController, "routing" do

  it "should route correctly" do
    {:get  => '/images'        }.should route_to(:controller => "images", :action => "index")
    #{:get  => '/'                         }.should route_to(:controller => "images", :action => "index")
    #{:get  => '/images/new'    }.should route_to(:controller => "images", :action => "new")
    #{:get  => '/images/1/edit' }.should route_to(:controller => "images", :action => "edit", :id=>"1")
    #{:put  => '/images/1'      }.should route_to(:controller => "images", :action => "update", :id=>"1")
    #{:post => '/images'        }.should route_to(:controller => "images", :action => "create")
  end

end
