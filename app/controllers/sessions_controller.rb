class SessionsController < ApplicationController
  skip_before_filter :authenticate, :only => [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save
    return_to_page_requested_or root_url
  end

end