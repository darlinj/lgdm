require 'spec_helper'

describe SessionsController, "routing" do

  it "should route correctly" do
    {:get  => '/login'     }.should route_to(:controller => "sessions", :action => "new")
    {:post  => '/sessions' }.should route_to(:controller => "sessions", :action => "create")
  end

end
