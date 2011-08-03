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

describe SessionsController, "create - unsuccessful login" do
  let(:session) {mock(UserSession, :save => false)}
  before do
    UserSession.stub(:new).and_return(session)
  end

  def do_request
    post :create, :user_session => :login_details
  end

  subject { do_request; @controller     }
    it    { should render_template(:new)}
    it    { should set_the_flash.to(/unsuccessful/) }
end

describe SessionsController, "destroy - logout" do
  before do
    stub_logged_in
    session = mock(UserSession, :destroy => true)
    controller.stub(:current_user_session).and_return(session)
  end

  def do_request
    delete :destroy
  end

  subject { do_request; @controller     }
    it    { should redirect_to(:root)             }
    it    { should set_the_flash.to(/logged out/) }
end
