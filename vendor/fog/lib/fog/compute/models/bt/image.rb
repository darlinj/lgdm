require 'fog/core/model'

module Fog
  module BT
    class Compute

      class Image < Fog::Model

        identity :id,                     :aliases => 'imageId'

        attribute :architecture
        attribute :location,              :aliases => 'imageLocation'
        attribute :owner_id,              :aliases => 'imageOwnerId'
        attribute :state,                 :aliases => 'imageState'
        attribute :type,                  :aliases => 'imageType'
        attribute :is_public,             :aliases => 'isPublic'
        attribute :kernel_id,             :aliases => 'kernelId'
        attribute :platform
        attribute :ramdisk_id,            :aliases => 'ramdiskId'

      end

    end
  end
end

