module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/describe_addresses'

        # Describe all or specified IP addresses.
        #
        # ==== Parameters
        # * public_ips - List of ip addresses to limit results with
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'addressesSet'<~Array>:
        #       * 'instanceId'<~String> - instance for ip address
        #       * 'publicIp'<~String> - ip address for instance
        def describe_addresses(*public_ips)
          request({
            'Action'    => 'DescribeAddresses',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::DescribeAddresses.new
          }.merge!(indexed_params('PublicIp', *public_ips)))
        end

      end

      class Mock

        def describe_addresses(*public_ips)
          response = Excon::Response.new

          addresses_set = @data[:addresses].values

          unless public_ips.empty?
            addresses_set.delete_if { |a| !public_ips.include?(a['publicIp'])  }
          end

          response.status = 200
          response.body = {
            'requestId'     => Fog::BT::Mock.request_id,
            'addressesSet'  => addresses_set
          }
          response
        end

      end
    end
  end
end
