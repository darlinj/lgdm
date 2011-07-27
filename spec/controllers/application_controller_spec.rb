require 'spec_helper'

describe ApplicationController, "#current_user" do
  context "when there is a user_session" do
    let(:user) { mock User }
    let(:user_session) { mock(UserSession, :record => user) }

    before do
      UserSession.stub(:find).and_return(user_session)
    end

    it "returns the user object" do
      controller.current_user.should == user
    end
  end

  context "when there is not a user_session" do
    before do
      UserSession.stub(:find).and_return(nil)
    end

    it "returns the user object" do
      controller.current_user.should == nil
    end
  end
end

describe ApplicationController, "blocking access to pages when not logged in" do
  controller do
    def index
      render :text => "the page"
    end
  end

  it "should redirect to the login page for normal actions" do
    get(:index).should redirect_to(login_path)
  end

  it "should save the source location" do
    get(:index)
    session[:return_to].should == "/anonymous"
  end

end

describe ApplicationController, "redirecting to return_to location if set" do
  controller do
    def index
      return_to_page_requested_or(:root)
    end
  end

  it "should redirect to the return_to uri in the session if set" do
    controller.stub(:authenticate).and_return(true)
    session[:return_to] = "/some/place"
    get(:index).should redirect_to("/some/place")
  end

  it "should redirect to the default page if return_to is not set" do
    controller.stub(:authenticate).and_return(true)
    session[:return_to] = nil
    get(:index).should redirect_to(:root)
  end

end

