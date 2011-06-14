require 'spec_helper'

describe ServersController, "create" do
  before do
  end

  def do_request
    post :create
  end

  subject { do_request; @controller    }
    it    { should redirect_to(:servers) }
end


