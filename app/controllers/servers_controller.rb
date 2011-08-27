class ServersController < ApplicationController
  def index
    cloud = Cloud.new( :provider => Rails.application.config.provider,
                       :region => Rails.application.config.region,
                       :bt_access_key_id => Rails.application.config.bt_access_key_id,
                       :bt_secret_access_key => Rails.application.config.bt_secret_access_key)
    @servers = cloud.servers
    @page = "servers"
  end

  def create
    cloud = Cloud.new( :provider => Rails.application.config.provider,
                       :region => Rails.application.config.region,
                       :bt_access_key_id => Rails.application.config.bt_access_key_id,
                       :bt_secret_access_key => Rails.application.config.bt_secret_access_key)
    cloud.run_image(params[:image_id])
    redirect_to :action => :index
  end
end
