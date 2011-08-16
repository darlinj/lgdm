class ImagesController < ApplicationController
  def index
    @images = current_user.cloud_images
  end
end
