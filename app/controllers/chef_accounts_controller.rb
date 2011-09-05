class ChefAccountsController < ApplicationController
  def index
    @chef_accounts = current_user.chef_accounts
    @page = "chef_accounts"
  end

  def new
    @chef_account = ChefApiAccount.new
    @page = "chef_accounts"
  end

  def create
    @chef_account = current_user.create_chef_account(params[:chef_account])
    @page = "chef_accounts"
    if @chef_account.save
      flash[:success] = "Chef Account created"
      redirect_to :chef_accounts
    else
      flash[:error] = "Creation unsuccessful."
      render :action => :new
    end
  end

end
