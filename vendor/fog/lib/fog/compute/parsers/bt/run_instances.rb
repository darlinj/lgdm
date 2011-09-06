require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class RunInstances < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @instance = { 'instanceState' => {},
                          'placement'     => {} }
            @response = { 'groupSet'      => [],
                          'instancesSet'  => [] }
          end

          def start_element(name, attrs = [])
            super
            case name
            when 'groupSet'
              @in_group_set = true
            end
          end

          def end_element(name)
            super
            case name
            when 'amiLaunchIndex'
              @instance[name] = @value.to_i
            when 'availabilityZone'
              @instance['placement'][name] = @value
            when 'dnsName',   'imageId', 'instanceId', 'instanceType',
                 'kernelId',  'keyName', 'platform',   'privateDnsName',
                 'ramdiskId', 'reason'
              @instance[name] = @value
            when 'code'
              @instance['instanceState'][name] = @value.to_i
            when 'groupId'
              @response['groupSet'] << @value
            when 'groupSet'
              @in_group_set = false
            when 'item'
              if !@in_group_set
                @response['instancesSet'] << @instance
                @instance = { 'instanceState' => {}, 'placement' => {} }
              end
            when 'launchTime'
              @instance[name] = Time.parse(@value)
            when 'name'
              @instance['instanceState'][name] = @value
            when 'ownerId', 'requestId', 'reservationId'
              @response[name] = @value
            end
          end
        end

      end
    end
  end
end


