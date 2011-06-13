class Image < ActiveRecord::Base
  def self.all
    Cloud.images
  end
end
