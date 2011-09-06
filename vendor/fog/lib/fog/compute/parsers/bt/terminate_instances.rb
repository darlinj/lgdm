require 'fog/compute/parsers/bt/base'

module Fog
  module Parsers
    module BT
      module Compute

        class TerminateInstances < Fog::Parsers::BT::Compute::Base

          def reset
            super
            @instance = { 'previousState' => {}, 'shutdownState' => {} }
            @response = { 'instancesSet' => [] }
          end

          def start_element(name, attrs = [])
            super
            if name == 'previousState'
              @in_previous_state = true
            elsif name == 'shutdownState'
              @in_shutdown_state = true
            end
          end

          def end_element(name)
            super
            case name
            when 'instanceId'
              @instance[name] = @value
            when 'item'
              @response['instancesSet'] << @instance
              @instance = { 'previousState' => {}, 'shutdownState' => {} }
            when 'code'
              if @in_previous_state
                @instance['previousState'][name] = @value.to_i
              elsif @in_shutdown_state
                @instance['shutdownState'][name] = @value.to_i
              end
            when 'name'
              if @in_previous_state
                @instance['previousState'][name] = @value
              elsif @in_shutdown_state
                @instance['shutdownState'][name] = @value
              end
            when 'previousState'
              @in_previous_state = false
            when 'requestId'
              @response[name] = @value
            when 'shutdownState'
              @in_shutdown_state = false
            end
          end

        end

      end
    end
  end
end

