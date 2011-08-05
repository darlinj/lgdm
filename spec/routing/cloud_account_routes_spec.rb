require 'spec_helper'

describe CloudAccountsController, "routing" do

  it "should route correctly" do
    {:get  => '/cloud_accounts' }.should route_to(:controller => "cloud_accounts", :action => "index")
  end

end
