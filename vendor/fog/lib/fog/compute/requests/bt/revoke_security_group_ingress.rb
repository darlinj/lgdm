module Fog
  module BT
    class Compute
      class Real

        # Remove permissions from a security group
        #
        # ==== Parameters
        # * options<~Hash>:
        #   * 'CidrIp' - CIDR range
        #   * 'FromPort' - Start of port range (or -1 for ICMP wildcard)
        #   * 'GroupName' - Name of group to modify
        #   * 'IpProtocol' - Ip protocol, must be in ['tcp', 'udp', 'icmp']
        #   * 'ToPort' - End of port range (or -1 for ICMP wildcard)
        #
        # === Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def revoke_security_group_ingress(options = {})
          request({
            'Action'    => 'RevokeSecurityGroupIngress',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::Basic.new
          }.merge!(options))
        end

      end

      class Mock

        def revoke_security_group_ingress(options = {})
          response = Excon::Response.new
          group = @data[:security_groups][options['GroupName']]
          if group
            ingress = group['ipPermissions'].select {|permission|
              permission['fromPort']    == options['FromPort'] &&
              permission['ipProtocol']  == options['IpProtocol'] &&
              permission['toPort']      == options['ToPort'] &&
              (
                permission['ipRanges'].empty? ||
                (
                  permission['ipRanges'].first &&
                  permission['ipRanges'].first['cidrIp'] == options['CidrIp']
                )
              )
            }.first
            group['ipPermissions'].delete(ingress)
            response.status = 200
            response.body = {
              'requestId' => Fog::BT::Mock.request_id,
              'return'    => true
            }
            response
          else
            raise Fog::Service::Error.new("SOAP-ENV:Client => security group 803042689:'#{options['GroupName']}' not found")
          end
        end

      end
    end
  end
end

