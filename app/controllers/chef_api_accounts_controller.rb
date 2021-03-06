class ChefApiAccountsController < ApplicationController
  def index
    @chef_api_accounts = current_user.chef_api_accounts
    @page = "chef_accounts"
  end

  def new
    @chef_api_account = ChefApiAccount.new
    @page = "chef_accounts"
  end

  def create
    @chef_api_account = current_user.create_chef_account(params[:chef_api_account])
    @page = "chef_accounts"
    if @chef_api_account.save
      flash[:success] = "Chef Account created"
      redirect_to :chef_api_accounts
    else
      flash[:error] = "Creation unsuccessful."
      render :action => :new
    end
  end

  def edit
    @chef_api_account = current_user.chef_api_accounts.find(params[:id])
    @page = "chef_accounts"
  end

  def update
    chef_api_account = current_user.chef_api_accounts.find(params[:id])
    chef_api_account.update_attributes(params[:chef_api_account])
    redirect_to :action => :index
  end
end
