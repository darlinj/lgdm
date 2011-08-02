class UsersController < ApplicationController
  skip_before_filter :authenticate, :only => [:new, :create, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Registration successful.  You will shortly receive an email that will allow you to activate your account."
      redirect_to :root
    else
      flash[:success] = "Registration unsuccessful."
      render :action => :new
    end
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
