module Fog
  module BT
    class Compute
      class Real

        require 'fog/compute/parsers/bt/run_instances'


        # Launch specified instances
        #
        # ==== Parameters
        # * image_id<~String> - Id of machine image to load on instances
        # * min_count<~Integer> - Minimum number of instances to launch. If this
        #   exceeds the count of available instances, no instances will be
        #   launched.  Must be between 1 and maximum allowed for your account
        #   (by default the maximum for an account is 20)
        # * max_count<~Integer> - Maximum number of instances to launch. If this
        #   exceeds the number of available instances, the largest possible
        #   number of instances above min_count will be launched instead. Must
        #   be between 1 and maximum allowed for you account
        #   (by default the maximum for an account is 20)
        # * options<~Hash>:
        #   * 'Placement.AvailabilityZone'<~String> - Placement constraint for instances
        #   * 'BlockDeviceMapping'<~Array>: array of hashes
        #     * 'DeviceName'<~String> - where the volume will be exposed to instance
        #     * 'VirtualName'<~String> - volume virtual device name
        #   * 'SecurityGroup'<~Array> or <~String> - Name of security group(s) for instances (you must omit this parameter if using Virtual Private Clouds)
        #   * 'InstanceType'<~String> - Type of instance to boot. Valid options
        #     in ['m1.small', 'm1.large', 'm1.xlarge', 'c1.medium', 'c1.xlarge', 'm2.2xlarge', 'm2.4xlarge']
        #     default is 'm1.small'
        #   * 'KernelId'<~String> - Id of kernel with which to launch
        #   * 'KeyName'<~String> - Name of a keypair to add to booting instances
        #   * 'RamdiskId'<~String> - Id of ramdisk with which to launch
        #   * 'UserData'<~String> -  Additional data to provide to booting instances
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'groupSet'<~Array>: groups the instances are members in
        #       * 'groupName'<~String> - Name of group
        #     * 'instancesSet'<~Array>: returned instances
        #       * instance<~Hash>:
        #         * 'amiLaunchIndex'<~Integer> - reference to instance in launch group
        #         * 'dnsName'<~String> - public dns name, blank until instance is running
        #         * 'imageId'<~String> - image id of ami used to launch instance
        #         * 'instanceId'<~String> - id of the instance
        #         * 'instanceState'<~Hash>:
        #           * 'code'<~Integer> - current status code
        #           * 'name'<~String> - current status name
        #         * 'instanceType'<~String> - type of instance
        #         * 'kernelId'<~String> - Id of kernel used to launch instance
        #         * 'keyName'<~String> - name of key used launch instances or blank
        #         * 'launchTime'<~Time> - time instance was launched
        #         * 'placement'<~Hash>:
        #           * 'availabilityZone'<~String> - Availability zone of the instance
        #         * 'privateDnsName'<~String> - private dns name, blank until instance is running
        #         * 'ramdiskId'<~String> - Id of ramdisk used to launch instance
        #         * 'reason'<~String> - reason for most recent state transition, or blank
        #     * 'ownerId'<~String> - Id of owner
        #     * 'requestId'<~String> - Id of request
        #     * 'reservationId'<~String> - Id of reservation
        def run_instances(image_id, min_count, max_count, options = {})
          if security_groups = options.delete('SecurityGroup')
            options.merge!(indexed_params('SecurityGroup', [*security_groups]))
          end
          if options['UserData']
            options['UserData'] = Base64.encode64(options['UserData'])
          end

          request({
            'Action'    => 'RunInstances',
            'ImageId'   => image_id,
            'MinCount'  => min_count,
            'MaxCount'  => max_count,
            :idempotent => false,
            :parser     => Fog::Parsers::BT::Compute::RunInstances.new
          }.merge!(options))
        end

      end

      class Mock

        def run_instances(image_id, min_count, max_count, options = {})
          if @data[:instances].size < @data[:limits][:instances]
            response = Excon::Response.new
            response.status = 200

            group_set = [ (options['GroupId'] || 'default') ]
            instances_set = []
            reservation_id = Fog::BT::Mock.reservation_id

            min_count.times do |i|
              instance_id = Fog::BT::Mock.instance_id
              instance = {
                'amiLaunchIndex'      => i,
                'blockDeviceMapping'  => [],
                'clientToken'         => options['clientToken'],
                'dnsName'             => nil,
                'imageId'             => image_id,
                'instanceId'          => instance_id,
                'instanceState'       => { 'code' => 0, 'name' => 'pending' },
                'instanceType'        => options['InstanceType'] || 'm1.small',
                'kernelId'            => options['KernelId'] || Fog::BT::Mock.kernel_id,
                'launchTime'          => Time.now,
                'placement'           => { 'availabilityZone' => options['Placement.AvailabilityZone'] || Fog::BT::Mock.availability_zone },
                'privateDnsName'      => nil,
                'ramdiskId'           => options['RamdiskId'] || Fog::BT::Mock.ramdisk_id,
                'reason'              => nil,
              }
              instances_set << instance
              @data[:instances][instance_id] = instance.merge({
                'groupSet'            => group_set,
                'ownerId'             => @owner_id,
                'reservationId'       => reservation_id,
              })
            end
            response.body = {
              'groupSet'      => group_set,
              'instancesSet'  => instances_set,
              'ownerId'       => @owner_id,
              'requestId'     => Fog::BT::Mock.request_id,
              'reservationId' => reservation_id
            }
            response
          else
            raise Fog::Service::Error.new("SOAP-ENV:Client => Unable to run instances as user #{@data[:owner_id]} currently has #{@data[:limits][:instances]} instances when the maximum is #{@data[:limits][:instances]}.")
          end
        end

      end
    end
  end
end
