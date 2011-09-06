require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class DescribeInstances < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @instance     = { 'instanceState'   => {},
                              'placement'       => {} }
            @reservation  = { 'groupSet'        => [],
                              'instancesSet'    => [] }
            @response     = { 'reservationSet'  => [] }
          end

          def start_element(name, attrs = [])
            super
            case name
            when'groupSet'
              @in_subset = true
            when 'instancesSet'
              @in_instances_set = true
            when 'instanceState'
              @in_instance_state = true
            end
          end

          def end_element(name)
            super
            case name
            when 'amiLaunchIndex'
              @instance[name] = @value.to_i
            when 'availabilityZone'
              @instance['placement'][name] = @value
            when  'dnsName',   'imageId', 'instanceId', 'instanceType',
                  'kernelId',  'keyName', 'platform',   'privateDnsName',
                  'ramdiskId', 'reason'
              @instance[name] = @value
            when 'code'
              if @in_instance_state
                @instance['instanceState'][name] = @value.to_i
              elsif @in_state_reason
                @instance['stateReason'][name] = @value.to_i
              end
            when 'groupId'
              @reservation['groupSet'] << @value
            when 'groupSet'
              @in_subset = false
            when 'instancesSet'
              @in_instances_set = false
            when 'instanceState'
              @in_instance_state = false
            when 'item'
              if @in_instances_set
                @reservation['instancesSet'] << @instance
                @instance = { 'instanceState' => {}, 'placement' => {}, }
              elsif !@in_subset
                @response['reservationSet'] << @reservation
                @reservation = { 'groupSet' => [], 'instancesSet' => [] }
              end
            when 'launchTime'
              @instance[name] = Time.parse(@value)
            when 'name'
              if @in_instance_state
                @instance['instanceState'][name] = @value
              end
            when 'ownerId', 'reservationId'
              @reservation[name] = @value
            when 'requestId'
              @response[name] = @value
            end
          end

        end

      end
    end
  end
end

