require 'fog/core/collection'
require 'fog/compute/models/bt/security_group'

module Fog
  module BT
    class Compute

      class SecurityGroups < Fog::Collection

        model Fog::BT::Compute::SecurityGroup

        # Creates a new security group
        #
        # compute.security_groups.new
        #
        # ==== Returns
        #
        # Returns the details of the new image
        #
        #>> compute.security_groups.new
        #  <Fog::BT::Compute::SecurityGroup
        #    name=nil,
        #    description=nil,
        #    ip_permissions=nil,
        #    owner_id=nil
        #  >
        #

        def initialize(attributes)
          super
        end

        # Returns an array of all security groups that have been created
        #
        # compute.security_groups.all
        #
        # ==== Parameters
        # * group_names - List of group names to limit results to
        #
        # ==== Returns
        #
        # Returns an array of all security groups
        #
        #>> compute.security_groups.all
        #  <Fog::BT::Compute::SecurityGroups
        #    filters={}
        #    [
        #      <Fog::BT::Compute::SecurityGroup
        #        name="default",
        #        description="default group",
        #        ip_permissions=[{"groups"=>[], "fromPort"=>-1, "toPort"=>-1, "ipRanges"=>[], "ipProtocol"=>"icmp"}, {"groups"=>[], "fromPort"=>0, "toPort"=>65535, "ipRanges"=>[], "ipProtocol"=>"tcp"}, {"groups"=>[], "fromPort"=>0, "toPort"=>65535, "ipRanges"=>[], "ipProtocol"=>"udp"}],
        #        owner_id="312571045469"
        #      >
        #    ]
        #  >
        #

        def all(*group_names)
          data = connection.describe_security_groups.body
          security_groups = load(data['securityGroupInfo'])
          if group_names.empty?
            security_groups
          else
            security_groups.select { |sg| group_names.include?(sg.name) }
          end
        end

        # Used to retreive a security group
        # group name is required to get the associated flavor information.
        #
        # You can run the following command to get the details:
        # compute.security_groups.get("default")
        #
        # ==== Returns
        #
        #>> compute.security_groups.get("default")
        #  <Fog::BT::Compute::SecurityGroup
        #    name="default",
        #    description="default group",
        #    ip_permissions=[{"groups"=>[], "fromPort"=>-1, "toPort"=>-1, "ipRanges"=>[], "ipProtocol"=>"icmp"}, {"groups"=>[], "fromPort"=>0, "toPort"=>65535, "ipRanges"=>[], "ipProtocol"=>"tcp"}, {"groups"=>[], "fromPort"=>0, "toPort"=>65535, "ipRanges"=>[], "ipProtocol"=>"udp"}],
        #    owner_id="312571045469"
        #  >
        #

        def get(group_name)
          if group_name
            self.class.new(:connection => connection).all(group_name).first
          end
        end

      end

    end
  end
end

