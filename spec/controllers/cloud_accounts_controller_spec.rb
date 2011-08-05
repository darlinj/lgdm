require 'spec_helper'

describe CloudAccountsController, "index" do
  before do
    stub_logged_in
    user = mock(User, :cloud_accounts => :some_accounts)
    controller.stub(:current_user).and_return(user)
  end

  def do_request
    get :index
  end

  subject { do_request; @controller                                       }
    it    { should assign_to(:cloud_accounts).with(:some_accounts) }
    it    { should render_template(:index)                                }
end


