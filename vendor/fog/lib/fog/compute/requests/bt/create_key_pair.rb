module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/create_key_pair'

        # Create a new key pair
        #
        # ==== Parameters
        # * key_name<~String> - Unique name for key pair.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'keyFingerprint'<~String> - SHA-1 digest of DER encoded private key
        #     * 'keyMaterial'<~String> - Unencrypted encoded PEM private key
        #     * 'keyName'<~String> - Name of key
        #     * 'requestId'<~String> - Id of request
        def create_key_pair(key_name)
          request(
            'Action'  => 'CreateKeyPair',
            'KeyName' => key_name,
            :parser   => Fog::Parsers::BT::Compute::CreateKeyPair.new
          )
        end

      end

      class Mock

        def create_key_pair(key_name)
          response = Excon::Response.new
          unless @data[:key_pairs][key_name]
            response.status = 200
            data = {
              'keyFingerprint'  => Fog::BT::Mock.key_fingerprint,
              'keyMaterial'     => Fog::BT::Mock.key_material,
              'keyName'         => key_name
            }
            @data[:key_pairs][key_name] = data
            response.body = {
              'requestId' => Fog::BT::Mock.request_id
            }.merge!(data)
            response
          else
            raise Fog::Service::Error.new("Fog::Service::Error: SOAP-ENV:Client => Key pair #{key_name} already exists for user #{@data[:owner_id]}")
          end
        end

      end
    end
  end
end

