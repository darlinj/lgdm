class ImagesController < ApplicationController
  def index
    cloud = Cloud.new( :provider => "BT",
                       :region => "pi-baynard-stable",
                       :bt_access_key_id => "xbZzzvlujsdOBjWVHeuQ",
                       :bt_secret_access_key => "dU53SYb0Hvn8qRxxprOf_G4HUJtNp3hctgnFJQ.."
    )
    @images = cloud.images
  end
end
