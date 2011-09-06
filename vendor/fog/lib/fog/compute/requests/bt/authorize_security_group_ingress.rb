module Fog
  module BT
    class Compute
      class Real

        # Add permissions to a security group
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
        def authorize_security_group_ingress(options = {})
          request({
            'Action'    => 'AuthorizeSecurityGroupIngress',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::Basic.new
          }.merge!(options))
        end

      end

      class Mock

        def authorize_security_group_ingress(options = {})
          response  = Excon::Response.new
          group     = @data[:security_groups][options['GroupName']]

          if group
            group['ipPermissions'] ||= []
            group['ipPermissions'] << {
              'groups'      => [],
              'fromPort'    => options['FromPort'],
              'ipRanges'    => [],
              'ipProtocol'  => options['IpProtocol'],
              'toPort'      => options['ToPort']
            }
            if options['CidrIp']
              group['ipPermissions'].last['ipRanges'] << { 'cidrIp' => options['CidrIp'] }
            end
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
