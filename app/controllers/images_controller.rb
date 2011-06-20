class ImagesController < ApplicationController
  def index
    cloud = Cloud.new( :provider => Rails.application.config.provider,
                       :region => Rails.application.config.region,
                       :bt_access_key_id => Rails.application.config.bt_access_key_id,
                       :bt_secret_access_key => Rails.application.config.bt_secret_access_key
    )
    @images = cloud.images
  end
end
