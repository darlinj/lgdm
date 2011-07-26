class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    user.reset_perishable_token!
    user.save
    flash[:success] = "Registration successful.  You will shortly receive an email that will allow you to activate your account."
    redirect_to :root
  end

  def update
    user = User.find_by_perishable_token(params[:token])
    user.reset_perishable_token!
    if user
      flash[:success] = "Activation successful"
      redirect_to :root
    end
  end
end
