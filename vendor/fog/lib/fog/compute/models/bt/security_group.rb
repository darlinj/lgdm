require 'fog/core/model'

module Fog
  module BT
    class Compute

      class SecurityGroup < Fog::Model

        identity  :name,            :aliases => 'groupName'

        attribute :description,     :aliases => 'groupDescription'
        attribute :ip_permissions,  :aliases => 'ipPermissions'
        attribute :owner_id,        :aliases => 'ownerId'

        # Authorize a new port range for a security group
        #
        #  >> g = compute.security_groups.all(:description => "something").first
        #  >> g.authorize_port_range(20..21)
        #
        # == Parameters:
        # range::
        #   A Range object representing the port range you want to open up. E.g., 20..21
        #
        # options::
        #   A hash that can contain any of the following keys:
        #    :cidr_ip (defaults to "0.0.0.0/0")
        #    :ip_protocol (defaults to "tcp")
        #
        # == Returns:
        #
        # An excon response object representing the result
        #
        #  <Excon::Response:0x101fc2ae0
        #    @status=200,
        #    @body=nil,
        #    headers{"Soapaction"=>"\"\"",
        #            "Content-type"=>"text/xml",
        #            "Content-length"=>"253",
        #            "Accept"=>"text/xml, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"}
        #

        def authorize_port_range(range, options = {})
          requires :name

          connection.authorize_security_group_ingress(
            'CidrIp'      => options[:cidr_ip] || '0.0.0.0/0',
            'FromPort'    => range.min,
            'GroupName'   => name,
            'ToPort'      => range.max,
            'IpProtocol'  => options[:ip_protocol] || 'tcp'
          )
        end

        # Removes an existing security group
        #
        # security_group.destroy
        #
        # ==== Returns
        #
        # True or false depending on the result
        #

        def destroy
          requires :name

          connection.delete_security_group(name)
          true
        end

        # Revoke an existing port range for a security group
        #
        #  >> g = compute.security_groups.all(:description => "something").first
        #  >> g.revoke_port_range(20..21)
        #
        # == Parameters:
        # range::
        #   A Range object representing the port range you want to revoke. E.g., 20..21
        #
        # options::
        #   A hash that can contain any of the following keys:
        #    :cidr_ip (defaults to "0.0.0.0/0")
        #    :ip_protocol (defaults to "tcp")
        #
        # == Returns:
        #
        # An excon response object representing the result
        #
        #  <Excon::Response:0x101fc2ae0
        #    @status=200,
        #    @body=nil,
        #    headers{"Soapaction"=>"\"\"",
        #            "Content-type"=>"text/xml",
        #            "Content-length"=>"247",
        #            "Accept"=>"text/xml, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2"}
        #

        def revoke_port_range(range, options = {})
          requires :name

          connection.revoke_security_group_ingress(
            'CidrIp'      => options[:cidr_ip] || '0.0.0.0/0',
            'FromPort'    => range.min,
            'GroupName'   => name,
            'ToPort'      => range.max,
            'IpProtocol'  => options[:ip_protocol] || 'tcp'
          )
        end

        # Create a security group
        #
        #  >> g = compute.security_groups.new(:name => "some_name", :description => "something")
        #  >> g.save
        #
        # == Returns:
        #
        # true 
        #

        def save
          requires :description, :name

          data = connection.create_security_group(name, description).body
          true
        end

      end

    end
  end
end

