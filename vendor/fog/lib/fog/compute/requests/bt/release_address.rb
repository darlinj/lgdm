module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/basic'

        # Release an elastic IP address.
        #
        # ==== Parameters
        # * public_ip - The elastic IP to release
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def release_address(public_ip)
          request(
            'Action'    => 'ReleaseAddress',
            'PublicIp'  => public_ip,
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::Basic.new
          )
        end

      end

      class Mock

        def release_address(public_ip)
          response = Excon::Response.new
          @data[:addresses].delete(public_ip)
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

