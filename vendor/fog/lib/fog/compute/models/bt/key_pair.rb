require 'fog/core/model'

module Fog
  module BT
    class Compute

      class KeyPair < Fog::Model

        identity  :name,        :aliases => 'keyName'

        attribute :fingerprint, :aliases => 'keyFingerprint'
        attribute :private_key, :aliases => 'keyMaterial'

        def destroy
          requires :name

          connection.delete_key_pair(name)
          true
        end

        def save
          requires :name

          data = connection.create_key_pair(name).body
          new_attributes = data.reject { |k,v| !['keyFingerprint', 'keyMaterial', 'keyName'].include?(k) }
          merge_attributes(new_attributes)
          true
        end

      end

    end
  end
end
