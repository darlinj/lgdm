class ServersController < ApplicationController
  def index
    @servers = Cloud.servers
  end

  def create
    redirect_to :action => :index
  end
end
