module Fog
  module BT
    class Compute
      class Real

        # Disassociate an elastic IP address from its instance (if any)
        #
        # ==== Parameters
        # * public_ip<~String> - Public ip to disassociate from instance
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def disassociate_address(public_ip)
          request(
            'Action'    => 'DisassociateAddress',
            'PublicIp'  => public_ip,
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::Basic.new
          )
        end

      end

      class Mock

        def disassociate_address(public_ip)
          response        = Excon::Response.new
          response.status = 200
          if address = @data[:addresses][public_ip]
            instance_id             = address['instanceId']
            instance                = @data[:instances][instance_id]
            instance['dnsName']     = instance['originaldnsName'] if instance
            address['instanceId']   = nil
            response.status = 200
            response.body = {
              'requestId' => Fog::BT::Mock.request_id,
              'return'    => true
            }
            response
          else
            raise Fog::Service::Error.new("SOAP-ENV:Client => IP address #{public_ip} not found for user #{@data[:owner_id]}")
          end
        end

      end
    end
  end
end

