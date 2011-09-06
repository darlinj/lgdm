require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class Basic < Fog::Parsers::BT::Compute::Base

          def end_element(name)
            super
            case name
            when 'requestId'
              @response[name] = @value
            when 'return'
              if @value == 'true'
                @response[name] = true
              else
                @response[name] = false
              end
            end
          end

        end
      end
    end
  end
end
