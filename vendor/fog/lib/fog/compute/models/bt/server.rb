require 'fog/core/model'

module Fog
  module BT
    class Compute

      class Server < Fog::Model

        identity  :id,                    :aliases => 'instanceId'

        attribute :ami_launch_index,      :aliases => 'amiLaunchIndex'
        attribute :availability_zone,     :aliases => ['availabilityZone', 'placement'],
                                          :squash  => 'availabilityZone'
        attribute :created_at,            :aliases => 'launchTime'
        attribute :dns_name,              :aliases => 'dnsName'
        attribute :flavor_id,             :aliases => 'instanceType'
        attribute :groups
        attribute :image_id,              :aliases => 'imageId'
        attribute :kernel_id,             :aliases => 'kernelId'
        attribute :key_name,              :aliases => 'keyName'
        attribute :platform
        attribute :private_dns_name,      :aliases => 'privateDnsName'
        attribute :ramdisk_id,            :aliases => 'ramdiskId'
        attribute :reason
        attribute :state,                 :aliases => 'instanceState', :squash => 'name'
        attribute :user_data

        attr_writer   :private_key, :private_key_path, :private_key_directory, :username

        def initialize(attributes={})
          self.groups     ||= ["default"]
          self.flavor_id  ||= 'm1.small'
          super
        end

        def console_output
          requires :id
          connection.get_console_output(id)
        end

        def destroy
          requires :id
          connection.terminate_instances(id)
          true
        end

        remove_method :flavor_id
        def flavor_id
          @flavor && @flavor.id || attributes[:flavor_id]
        end

        def flavor=(new_flavor)
          @flavor = new_flavor
        end

        def flavor
          @flavor ||= connection.flavors.all.detect {|flavor| flavor.id == flavor_id}
        end

        def key_pair
          requires :key_name

          connection.key_pairs.all(key_name).first
        end

        def key_pair=(new_keypair)
          self.key_name = new_keypair && new_keypair.name
        end

        def private_key_directory
          @private_key_directory ||= Fog.credentials[:private_key_directory]
          @private_key_directory &&= File.expand_path(@private_key_directory)
        end

        def private_key_path
          @private_key_path ||= private_key_directory && File.join(private_key_directory, "#{key_name}.pem")
        end

        def private_key
          @private_key ||= private_key_path && File.read(private_key_path)
        end

        def ready?
          state == 'running'
        end

        def reboot
          requires :id
          connection.reboot_instances(id)
          true
        end

        def save
          raise Fog::Errors::Error.new('Resaving an existing object may create a duplicate') if identity
          requires :image_id

          options = {
            'InstanceType'                => flavor_id,
            'KernelId'                    => kernel_id,
            'KeyName'                     => key_name,
            'Placement.AvailabilityZone'  => availability_zone,
            'RamdiskId'                   => ramdisk_id,
            'SecurityGroup'               => groups,
            'UserData'                    => user_data
          }
          options.delete_if {|key, value| value.nil?}

          data = connection.run_instances(image_id, 1, 1, options)
          merge_attributes(data.body['instancesSet'].first)
          true
        end

        def ssh(commands)
          requires :identity, :dns_name, :username

          options = {}
          options[:key_data] = [private_key] if private_key
          Fog::SSH.new(dns_name, username, options).run(commands)
        end

        def username
          @username ||= 'root'
        end
      end

    end
  end
end
