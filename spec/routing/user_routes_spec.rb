require 'spec_helper'

describe UsersController, "routing" do

  it "should route correctly" do
    {:get  => '/register'        }.should route_to(:controller => "users", :action => "new")
    {:post => '/users'           }.should route_to(:controller => "users", :action => "create")
  end

end
