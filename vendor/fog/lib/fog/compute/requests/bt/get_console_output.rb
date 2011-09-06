module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/get_console_output'

        # Retrieve console output for specified instance
        #
        # ==== Parameters
        # * instance_id<~String> - Id of instance to get console output from
        #
        # ==== Returns
        # # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'instanceId'<~String> - Id of instance
        #     * 'output'<~String> - Console output
        #     * 'requestId'<~String> - Id of request
        #     * 'timestamp'<~Time> - Timestamp of last update to output
        def get_console_output(instance_id)
          request(
            'Action'      => 'GetConsoleOutput',
            'InstanceId'  => instance_id,
            :idempotent   => true,
            :parser       => Fog::Parsers::BT::Compute::GetConsoleOutput.new
          )
        end

      end

      class Mock

        def get_console_output(instance_id)
          response = Excon::Response.new
          if instance = @data[:instances][instance_id]
            response.status = 200
            response.body = {
              'instanceId'    => instance_id,
              'output'        => nil,
              'requestId'     => Fog::BT::Mock.request_id,
              'timestamp'     => Time.now
            }
            response
          else;
            raise Fog::Service::Error.new("SOAP-ENV:Client => Instance #{instance_id} does not exist in the system.")
          end
        end

      end
    end
  end
end

