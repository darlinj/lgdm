module Fog
  module AWS
    class DNS
      class Real

        require 'fog/dns/parsers/aws/delete_hosted_zone'

        # Delete a hosted zone
        #
        # ==== Parameters
        # * zone_id<~String> - 
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'ChangeInfo'<~Hash> -
        #       * 'Id'<~String> The ID of the request
        #       * 'Status'<~String> The current state of the hosted zone
        #       * 'SubmittedAt'<~String> The date and time the change was made
        #   * status<~Integer> - 200 when successful
        def delete_hosted_zone(zone_id)

          # AWS methods return zone_ids that looks like '/hostedzone/id'.  Let the caller either use 
          # that form or just the actual id (which is what this request needs)
          zone_id = zone_id.sub('/hostedzone/', '')
          
          request({
            :expects    => 200,
            :parser     => Fog::Parsers::AWS::DNS::DeleteHostedZone.new,
            :method     => 'DELETE',
            :path       => "hostedzone/#{zone_id}"
          })

        end

      end


      class Mock

        def delete_hosted_zone(zone_id)
          Fog::Mock.not_implemented
        end

      end
    end
  end
end
