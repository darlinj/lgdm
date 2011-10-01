class ServersController < ApplicationController
  def index
    #cloud = params[:cloud] ? params[:cloud] : current_user.cloud_accounts.first
    @page = "servers"
    if (params[:cloud_id])
      @servers = current_user.cloud_servers(params[:cloud_id])
      render :partial => "server_list"
    else
      @cloud_accounts = current_user.cloud_accounts
    end
  end

  def create
    current_user.start_server(params[:image_id])
    redirect_to :action => :index
  end
end
