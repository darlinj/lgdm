module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/describe_security_groups'

        # Describe all security groups
        #
        # === Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'securityGroupInfo'<~Array>:
        #       * 'groupDescription'<~String> - Description of security group
        #       * 'groupName'<~String> - Name of security group
        #       * 'ipPermissions'<~Array>:
        #         * 'fromPort'<~Integer> - Start of port range (or -1 for ICMP wildcard)
        #         * 'groups'<~Array>:
        #           * [] - this array is always empty
        #         * 'ipProtocol'<~String> - Ip protocol, must be in ['tcp', 'udp', 'icmp']
        #         * 'ipRanges'<~Array>:
        #           * 'cidrIp'<~String> - CIDR range
        #         * 'toPort'<~Integer> - End of port range (or -1 for ICMP wildcard)
        #       * 'ownerId'<~String> - AWS Access Key Id of the owner of the security group
        def describe_security_groups
          request({
            'Action'    => 'DescribeSecurityGroups',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::DescribeSecurityGroups.new
          })
        end

      end

      class Mock

        def describe_security_groups
          security_group_info = @data[:security_groups].values
          response            = Excon::Response.new
          response.status     = 200
          response.body = {
            'requestId'         => Fog::BT::Mock.request_id,
            'securityGroupInfo' => security_group_info
          }
          response
        end

      end
    end
  end
end

