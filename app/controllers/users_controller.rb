class UsersController < ApplicationController
  skip_before_filter :authenticate, :only => [:new, :create, :update]
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    #user.reset_perishable_token!
    user.save#_without_session_maintenance
    flash[:success] = "Registration successful.  You will shortly receive an email that will allow you to activate your account."
    redirect_to :root
  end

  def update
    user = User.find_by_perishable_token(params[:token])
    if user
      user.activate!
      flash[:success] = "Activation successful"
      redirect_to :root
    end
  end
end
