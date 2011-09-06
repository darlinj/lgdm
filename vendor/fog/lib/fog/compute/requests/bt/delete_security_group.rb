module Fog
  module BT
    class Compute
      class Real

        # Delete a security group that you own
        #
        # ==== Parameters
        # * group_name<~String> - Name of the security group.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def delete_security_group(name)
          request(
            'Action'    => 'DeleteSecurityGroup',
            'GroupName' => name,
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::Basic.new
          )
        end

      end

      class Mock

        def delete_security_group(name)
          response = Excon::Response.new
          if @data[:security_groups][name]
            @data[:security_groups].delete(name)
          end
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

