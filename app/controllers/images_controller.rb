class ImagesController < ApplicationController
  def index
    @images = current_user.cloud_images
    @page = "images"
  end
end
