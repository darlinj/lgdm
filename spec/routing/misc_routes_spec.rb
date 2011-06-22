require 'spec_helper'

describe PagesController, "routing" do

  it "should route correctly" do
    {:get  => '/'        }.should route_to(:controller => "pages", :action => "home")
  end

end
