module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/terminate_instances'

        # Terminate specified instances
        #
        # ==== Parameters
        # * instance_id<~Array> - Ids of instances to terminates
        #
        # ==== Returns
        # # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'instancesSet'<~Array>:
        #       * 'instanceId'<~String> - id of the terminated instance
        #       * 'previousState'<~Hash>: previous state of instance
        #         * 'code'<~Integer> - previous status code
        #         * 'name'<~String> - name of previous state
        #       * 'shutdownState'<~Hash>: shutdown state of instance
        #         * 'code'<~Integer> - current status code
        #         * 'name'<~String> - name of current state
        def terminate_instances(*instance_ids)
          request({
            'Action'    => 'TerminateInstances',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::TerminateInstances.new
          }.merge!(indexed_params('InstanceId', *instance_ids)))
        end

      end

      class Mock

        def terminate_instances(*instance_ids)
          response = Excon::Response.new
          if (@data[:instances].keys & instance_ids).length == instance_ids.length
            response.body = {
              'requestId'     => Fog::BT::Mock.request_id,
              'instancesSet'  => []
            }
            response.status = 200
            instance_ids.each do |instance_id|
              instance                          = @data[:instances][instance_id]
              @data[:deleted_at][instance_id]   = Time.now
              code =  case instance['instanceState']['name']
                      when 'pending'
                        0
                      when 'running'
                        16
                      when 'shutting-down'
                        32
                      when 'terminated'
                        48
                      when 'stopping'
                        64
                      when 'stopped'
                        80
                      end
              state = { 'name' => 'shutting-down', 'code' => 32}
              response.body['instancesSet'] << {
                'instanceId'    => instance_id,
                'previousState' => instance['instanceState'],
                'currentState'  => state
              }
              instance['instanceState'] = state
            end

            describe_addresses.body['addressesSet'].each do |address|
              if instance_ids.include?(address['instanceId'])
                disassociate_address(address['publicIp'])
              end
            end

            response
          else
            raise Fog::Service::Error.new("SOAP-ENV:Client => Internal Server Error")
          end
        end

      end
    end
  end
end
