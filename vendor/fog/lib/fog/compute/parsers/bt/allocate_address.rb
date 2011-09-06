require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class AllocateAddress < Fog::Parsers::BT::Compute::Base

          def end_element(name)
            super
            case name
            when 'publicIp', 'requestId'
              @response[name] = @value
            end
          end

        end
      end
    end
  end
end
