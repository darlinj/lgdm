module Fog
  module BT
    class Compute
      class Real

        # Associate an elastic IP address with an instance
        #
        # ==== Parameters
        # * instance_id<~String> - Id of instance to associate address with
        # * public_ip<~String> - Public ip to assign to instance
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def associate_address(instance_id, public_ip)
          request(
            'Action'      => 'AssociateAddress',
            'InstanceId'  => instance_id,
            'PublicIp'    => public_ip,
            :idempotent   => true,
            :parser       => Fog::Parsers::BT::Compute::Basic.new
          )
        end

      end

      class Mock

        def associate_address(instance_id, public_ip)
          response        = Excon::Response.new
          response.status = 200
          instance        = @data[:instances][instance_id]
          address         = @data[:addresses][public_ip]
          if instance && address
            address['instanceId']         = instance_id
            instance['originaldnsName']   = instance['dnsName']
            instance['dnsName']           = public_ip
            response.status               = 200
            response.body = {
              'requestId' => Fog::BT::Mock.request_id,
              'return'    => true
            }
            response
          elsif !instance
            raise Fog::Service::Error.new("SOAP-ENV:Client => Instance #{instance_id} not found")
          elsif !address
            raise Fog::Service::Error.new("SOAP-ENV:Client => IP address #{public_ip} not found for user #{@data[:owner_id]}")
          end
        end

      end
    end
  end
end

