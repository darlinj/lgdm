module Fog
  module Parsers
    module BT
      module Compute

        class DescribeImages < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @image    = {  }
            @response = { 'imagesSet' => [] }
          end

          def end_element(name)
            super
            case name
            when 'architecture', 'imageId', 'imageLocation', 'imageOwnerId', 'imageState', 'imageType', 'kernelId', 'platform', 'ramdiskId'
              @image[name] = @value
            when 'isPublic'
              if @value == 'true'
                @image[name] = true
              else
                @image[name] = false
              end
            when 'item'
              @response['imagesSet'] << @image
              @image = {}
            when 'requestId'
              @response[name] = @value
            end
          end
        end
      end
    end
  end
end

