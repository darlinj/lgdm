module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/describe_instances'

        # Describe all or specified instances
        #
        # ==== Parameters
        # * instanceIds - List of instanceId to describe (optional)
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'reservationSet'<~Array>:
        #       * 'groupSet'<~Array> - Group names for reservation
        #       * 'ownerId'<~String> - AWS Access Key ID of reservation owner
        #       * 'reservationId'<~String> - Id of the reservation
        #       * 'instancesSet'<~Array>:
        #         * instance<~Hash>:
        #           * 'amiLaunchIndex'<~Integer> - reference to instance in launch group
        #           * 'dnsName'<~String> - public dns name, blank until instance is running
        #           * 'imageId'<~String> - image id of ami used to launch instance
        #           * 'instanceId'<~String> - id of the instance
        #           * 'instanceState'<~Hash>:
        #             * 'code'<~Integer> - current status code
        #             * 'name'<~String> - current status name
        #           * 'instanceType'<~String> - type of instance
        #           * 'kernelId'<~String> - id of kernel used to launch instance
        #           * 'keyName'<~String> - name of key used launch instances or blank
        #           * 'launchTime'<~Time> - time instance was launched
        #           * 'placement'<~Hash>:
        #             * 'availabilityZone'<~String> - Availability zone of the instance
        #           * 'platform'<~String> - the operating platform of the instance
        #           * 'privateDnsName'<~String> - private dns name, blank until instance is running
        #           * 'ramdiskId'<~String> - Id of ramdisk used to launch instance
        #           * 'reason'<~String> - reason for most recent state transition, or blank
        def describe_instances(*instance_ids)
          request({
            'Action'    => 'DescribeInstances',
            :idempotent => true,
            :parser     => Fog::Parsers::BT::Compute::DescribeInstances.new
          }.merge!(indexed_params('InstanceId', *instance_ids)))
        end
      end

      class Mock

        def describe_instances(*instance_ids)
          response = Excon::Response.new

          instance_set = @data[:instances].values

          unless instance_ids.empty?
            instance_set.delete_if { |a| !instance_ids.include?(a['instanceId'])  }
          end

          response.status = 200
          reservation_set = {}

          instance_set.each do |instance|
            case instance['instanceState']['name']
            when 'pending'
              if Time.now - instance['launchTime'] > Fog::Mock.delay
                instance['dnsName']           = Fog::BT::Mock.ip_address
                instance['privateDnsName']    = Fog::BT::Mock.ip_address
                instance['instanceState']     = { 'code' => 16, 'name' => 'running' }
              end
            when 'rebooting'
              instance['instanceState'] = { 'code' => 16, 'name' => 'running' }
            when 'shutting-down'
              if Time.now - @data[:deleted_at][instance['instanceId']] > Fog::Mock.delay * 2
                @data[:deleted_at].delete(instance['instanceId'])
                @data[:instances].delete(instance['instanceId'])
              elsif Time.now - @data[:deleted_at][instance['instanceId']] > Fog::Mock.delay
                instance['instanceState'] = { 'code' => 48, 'name' => 'terminating' }
              end
            when 'terminating'
              if Time.now - @data[:deleted_at][instance['instanceId']] > Fog::Mock.delay
                @data[:deleted_at].delete(instance['instanceId'])
                @data[:instances].delete(instance['instanceId'])
              end
            end

            if @data[:instances][instance['instanceId']]

              reservation_set[instance['reservationId']] ||= {
                'groupSet'      => instance['groupSet'],
                'instancesSet'  => [],
                'ownerId'       => instance['ownerId'],
                'reservationId' => instance['reservationId']
              }
              reservation_set[instance['reservationId']]['instancesSet'] << instance.reject{|key,value| !['amiLaunchIndex', 'architecture', 'blockDeviceMapping', 'clientToken', 'dnsName', 'imageId', 'instanceId', 'instanceState', 'instanceType', 'ipAddress', 'kernelId', 'keyName', 'launchTime', 'monitoring', 'placement', 'privateDnsName', 'privateIpAddress', 'productCodes', 'ramdiskId', 'reason', 'rootDeviceType', 'stateReason', 'tagSet'].include?(key)}
            end
          end

          response.body = {
            'requestId'       => Fog::BT::Mock.request_id,
            'reservationSet' => reservation_set.values
          }
          response
        end

      end
    end
  end
end

