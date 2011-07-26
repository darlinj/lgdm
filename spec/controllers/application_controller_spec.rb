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


