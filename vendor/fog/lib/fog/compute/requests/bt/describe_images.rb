module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/describe_images'

        # Describe all or specified images.
        #
        # ==== Params
        # * instanceIds - List of imageIds to describe (optional)
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'imagesSet'<~Array>:
        #       * 'architecture'<~String> - Architecture of the image
        #       * 'imageId'<~String> - Id of the image
        #       * 'imageLocation'<~String> - Location of the image
        #       * 'imageOwnerId'<~String> - Id of the owner of the image
        #       * 'imageState'<~String> - State of the image
        #       * 'imageType'<~String> - Type of the image
        #       * 'isPublic'<~Boolean> - Whether or not the image is public
        #       * 'kernelId'<~String> - Kernel id associated with image, if any
        #       * 'platform'<~String> - Operating platform of the image
        #       * 'ramdiskId'<~String> - Ramdisk id associated with image, if any
        def describe_images(*image_ids)
          options = {}
          request({
            'Action'    => 'DescribeImages',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::DescribeImages.new
          }.merge!(indexed_params('ImageId', *image_ids)))
        end

      end

      class Mock

        def describe_images(filters = {})

          response = Excon::Response.new
          image_set = @data[:images].values

          response.status = 200
          response.body = {
            'requestId' => Fog::BT::Mock.request_id,
            'imagesSet' => image_set
          }
          response
        end

      end
    end
  end
end

