require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class DescribeAddresses < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @address = {}
            @response = { 'addressesSet' => [] }
          end

          def end_element(name)
            super
            case name
            when 'instanceId', 'publicIp'
              @address[name] = @value
            when 'item'
              @response['addressesSet'] << @address
              @address = {}
            when 'requestId'
              @response[name] = @value
            end
          end

        end

      end
    end
  end
end

