require 'spec_helper'

describe SessionsController, "new" do
  before do
    UserSession.stub(:new).and_return(:some_session)
  end

  def do_request
    get :new
  end

  subject { do_request; @controller    }
  it    { should assign_to(:user_session).with(:some_session) }

end

describe SessionsController, "create - sucessful login" do
  let(:session) {mock(UserSession, :save => true)}
  before do
    UserSession.stub(:new).and_return(session)
  end

  def do_request
    post :create, :user_session => :login_details
  end

  it "should pass the params to the user session model" do
    UserSession.stub(:new).with(:login_details).and_return(session)
    do_request
  end

  subject { do_request; @controller    }
    it    { should redirect_to(:root) }
end
