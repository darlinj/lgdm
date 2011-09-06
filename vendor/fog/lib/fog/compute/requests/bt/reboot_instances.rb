module Fog
  module BT
    class Compute
      class Real

        # Reboot specified instances
        #
        # ==== Parameters
        # * instance_id<~Array> - Ids of instances to reboot
        #
        # ==== Returns
        # # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def reboot_instances(*instance_ids)
          request({
            'Action'    => 'RebootInstances',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::Basic.new
          }.merge!(indexed_params('InstanceId', *instance_ids)))
        end

      end

      class Mock

        def reboot_instances(*instance_ids)
          response    = Excon::Response.new
          response.status = 200
          response.body = {
            'requestId' => Fog::BT::Mock.request_id,
            'return'    => true
          }
          response
        end

      end
    end
  end
end
