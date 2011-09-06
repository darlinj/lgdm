require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class GetConsoleOutput < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @response = {}
          end

          def end_element(name)
            super
            case name
            when 'instanceId', 'requestId'
              @response[name] = @value
            when 'output'
              @response[name] = if @value
                Base64.decode64(@value)
              else
                nil
              end
            when 'timestamp'
              @response[name] = Time.parse(@value)
            end
          end

        end

      end
    end
  end
end
