module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/describe_key_pairs'

        # Describe all or specified key pairs
        #
        # ==== Parameters
        # * filters<~Hash> - List of filters to limit results with
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'keySet'<~Array>:
        #       * 'keyName'<~String> - Name of key
        #       * 'keyFingerprint'<~String> - Fingerprint of key
        def describe_key_pairs(*key_names)
          request({
            'Action'    => 'DescribeKeyPairs',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::DescribeKeyPairs.new
          }.merge!(indexed_params('KeyName', *key_names)))
        end

      end

      class Mock

        def describe_key_pairs(filters = {})
          response = Excon::Response.new

          key_set = @data[:key_pairs].values

          response.status = 200
          response.body = {
            'requestId' => Fog::BT::Mock.request_id,
            'keySet'    => key_set.map do |key_pair|
              key_pair.reject {|key,value| !['keyFingerprint', 'keyName'].include?(key)}
            end
          }
          response
        end

      end
    end
  end
end
