class CloudAccountsController < ApplicationController
  def index
    @cloud_accounts = current_user.cloud_accounts
    @page = "cloud_accounts"
  end

  def new
    @cloud_account = CloudAccount.new
    @page = "cloud_accounts"
  end

  def create
    @cloud_account = current_user.create_cloud_account(params[:cloud_account])
    @page = "cloud_accounts"
    if @cloud_account.save
      flash[:success] = "Cloud Account created"
      redirect_to :cloud_accounts
    else
      flash[:error] = "Creation unsuccessful."
      render :action => :new
    end
  end

  def edit
    @cloud_account = current_user.cloud_accounts.find(params[:id])
    @page = "cloud_accounts"
  end

  def update
    cloud_account = current_user.cloud_accounts.find(params[:id])
    cloud_account.update_attributes(params[:cloud_account])
    redirect_to :action => :index
  end

end
