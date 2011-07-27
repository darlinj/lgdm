class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :authenticate

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def authenticate
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def return_to_page_requested_or default
      redirect_to session[:return_to] || default
      session[:redirect_to] = nil
    end
end
