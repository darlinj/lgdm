class CloudAccountsController < ApplicationController
  def index
    @cloud_accounts = current_user.cloud_accounts
  end
end
