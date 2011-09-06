module Fog
  module Parsers
    module BT
      module Compute

        class CreateKeyPair < Fog::Parsers::BT::Compute::Base

          def end_element(name)
            super
            case name
            when 'keyFingerprint', 'keyMaterial', 'keyName', 'requestId'
              @response[name] = @value
            end
          end

        end

      end
    end
  end
end

