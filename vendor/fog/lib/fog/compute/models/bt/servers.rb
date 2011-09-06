require 'fog/core/collection'
require 'fog/compute/models/bt/server'

module Fog
  module BT
    class Compute

      class Servers < Fog::Collection

        model Fog::BT::Compute::Server

        # compute.servers.all
        #
        # ==== Parameters
        # * public_ips - List of server ids to limit results to
        #
        # ==== Returns
        #
        # Returns an array of all servers
        #
        #>> compute.servers.all
        #<Fog::BT::Compute::Servers
        #  [
        #    <Fog::BT::Compute::Server
        #      id="i-000AN2AP",
        #      ami_launch_index=0,
        #      availability_zone="lax1-a",
        #      created_at=Sat Feb 05 15:19:16 UTC 2011,
        #      dns_name="204.231.109.196",
        #      flavor_id="m1.small",
        #      groups=["default"],
        #      image_id="pmi-2cfa6611",
        #      kernel_id=nil,
        #      key_name=nil,
        #      platform="linux",
        #      private_dns_name="10.19.134.54",
        #      ramdisk_id=nil,
        #      reason=nil,
        #      state="terminated",
        #      user_data=nil
        #    >
        #  ]
        #>

        def all(*server_ids)
          data = connection.describe_instances(*server_ids).body
          load(
            data['reservationSet'].map do |reservation|
              reservation['instancesSet'].map do |instance|
                instance.merge(:groups => reservation['groupSet'])
              end
            end.flatten
          )
        end

        # Used to retreive a server
        #
        # server_id is required to get the associated server information.
        #
        # You can run the following command to get the details:
        # compute.servers.get("i-5c973972")
        #
        # ==== Returns
        #
        #>> compute.servers.get("i-5c973972")
        #<Fog::BT::Compute::Server
        #  id="i-000AN2AP",
        #  ami_launch_index=0,
        #  availability_zone="lax1-a",
        #  created_at=Sat Feb 05 15:19:16 UTC 2011,
        #  dns_name="204.231.109.196",
        #  flavor_id="m1.small",
        #  groups=["default"],
        #  image_id="pmi-2cfa6611",
        #  kernel_id=nil,
        #  key_name=nil,
        #  platform="linux",
        #  private_dns_name="10.19.134.54",
        #  ramdisk_id=nil,
        #  reason=nil,
        #  state="terminated",
        #  user_data=nil
        #> 

        def get(server_id)
          return unless server_id
          self.class.new(:connection => connection).all(server_id).first
        end
      end

    end
  end
end

