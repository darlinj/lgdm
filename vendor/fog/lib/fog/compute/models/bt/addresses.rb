require 'fog/core/collection'
require 'fog/compute/models/bt/address'

module Fog
  module BT
    class Compute

      class Addresses < Fog::Collection

        model Fog::BT::Compute::Address

        # compute.addresses.all
        #
        # ==== Parameters
        # * public_ips - List of ip addresses to limit results to
        #
        # ==== Returns
        #
        # Returns an array of all IP addresses
        #
        #>> compute.addresses.all
        #  <Fog::BT::Compute::Addresses
        #    [
        #      <Fog::BT::Compute::Address
        #        public_ip="76.7.46.54",
        #        server_id=nil
        #      >,
        #      .......
        #      <Fog::BT::Compute::Address
        #        public_ip="4.88.524.95",
        #        server_id=nil
        #      >
        #    ]
        #  >
        #>>
        def all(*public_ips)
          data = connection.describe_addresses(*public_ips).body
          load(
            data['addressesSet'].map do |address|
              address.reject {|key, value| value.nil? || value.empty? }
            end
          )
          self
        end

        # Used to retreive an IP address
        #
        # public_ip is required to get the associated IP information.
        #
        # You can run the following command to get the details:
        # compute.addresses.get("76.7.46.54")
        def get(public_ip)
          return unless public_ip
          self.class.new(:connection => connection).all(public_ip).first
        end
      end

    end
  end
end

