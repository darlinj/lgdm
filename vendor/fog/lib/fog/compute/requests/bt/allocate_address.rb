module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/allocate_address'

        # Acquire an elastic IP address.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'publicIp'<~String> - The acquired address
        #     * 'requestId'<~String> - Id of the request
        def allocate_address
          request(
            'Action'  => 'AllocateAddress',
            :parser   => Fog::Parsers::BT::Compute::AllocateAddress.new
          )
        end

      end

      class Mock

        def allocate_address
          response        = Excon::Response.new
          response.status = 200
          public_ip       = Fog::BT::Mock.ip_address
          @data[:addresses][public_ip] = {
            'instanceId' => nil,
            'publicIp'   => public_ip
          }
          response.body = {
            'publicIp'  => public_ip,
            'requestId' => Fog::BT::Mock.request_id
          }
          response
        end

      end
    end
  end
end

