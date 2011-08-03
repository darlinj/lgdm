require 'spec_helper'

describe SessionsController, "routing" do

  it "should route correctly" do
    {:get    => '/login'   }.should route_to(:controller => "sessions", :action => "new")
    {:post   => '/session' }.should route_to(:controller => "sessions", :action => "create")
    {:delete => '/session' }.should route_to(:controller => "sessions", :action => "destroy")
  end

end
