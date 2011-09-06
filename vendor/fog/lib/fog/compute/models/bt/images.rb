require 'fog/core/collection'
require 'fog/compute/models/bt/image'

module Fog
  module BT
    class Compute

      class Images < Fog::Collection

        model Fog::BT::Compute::Image

        # Creates a new Amazon machine image
        #
        # BT.images.new
        #
        # ==== Returns
        #
        # Returns the details of the new image
        #
        #>> BT.images.new
        #<Fog::BT::Compute::Image
        #  id=nil,
        #  architecture=nil,
        #  location=nil,
        #  owner_id=nil,
        #  state=nil,
        #  type=nil,
        #  is_public=nil,
        #  kernel_id=nil,
        #  platform=nil,
        #  ramdisk_id=nil
        #>
        #

        def initialize(attributes)
          super
        end

        def all(*image_ids)
          data = connection.describe_images(*image_ids).body
          load(data['imagesSet'])
        end

        def get(image_id)
          if image_id
            self.class.new(:connection => connection).all(image_id).first
          end
        end
      end

    end
  end
end

