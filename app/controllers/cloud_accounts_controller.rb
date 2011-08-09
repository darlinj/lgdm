class CloudAccountsController < ApplicationController
  def index
    @cloud_accounts = current_user.cloud_accounts
  end

  def new
    @cloud_account = CloudAccount.new
  end

  def create
    @cloud_account = current_user.create_cloud_account(params[:cloud_account])
    if @cloud_account.save
      flash[:success] = "Cloud Account created"
      redirect_to :cloud_accounts
    else
      flash[:error] = "Creation unsuccessful."
      render :action => :new
    end
  end

end
