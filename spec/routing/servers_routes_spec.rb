require 'spec_helper'

describe ServersController, "routing" do

  it "should route correctly" do
    {:get  => '/servers'        }.should route_to(:controller => "servers", :action => "index")
    {:post => '/servers'        }.should route_to(:controller => "servers", :action => "create")
    #{:get  => '/'                         }.should route_to(:controller => "servers", :action => "index")
    #{:get  => '/servers/new'    }.should route_to(:controller => "servers", :action => "new")
    #{:get  => '/servers/1/edit' }.should route_to(:controller => "servers", :action => "edit", :id=>"1")
    #{:put  => '/servers/1'      }.should route_to(:controller => "servers", :action => "update", :id=>"1")
  end

end
