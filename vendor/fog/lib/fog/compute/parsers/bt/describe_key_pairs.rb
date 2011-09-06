module Fog
  module Parsers
    module BT
      module Compute

        class DescribeKeyPairs < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @key = {}
            @response = { 'keySet' => [] }
          end

          def end_element(name)
            super
            case name
            when 'item'
              @response['keySet'] << @key
              @key = {}
            when 'keyFingerprint', 'keyName'
              @key[name] = @value
            when 'requestId'
              @response[name] = @value
            end
          end

        end

      end
    end
  end
end

