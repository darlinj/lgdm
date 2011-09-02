class ServersController < ApplicationController
  def index
    @servers = current_user.cloud_servers
    @page = "servers"
  end

  def create
    current_user.start_server(params[:image_id])
    redirect_to :action => :index
  end
end
