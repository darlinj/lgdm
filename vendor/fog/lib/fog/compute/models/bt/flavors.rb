require 'fog/core/collection'
require 'fog/compute/models/bt/flavor'

module Fog
  module BT
    class Compute

      class Flavors < Fog::Collection

        model Fog::BT::Compute::Flavor

        # Returns an array of all flavors that have been created
        #
        # compute.flavors.all
        #
        # ==== Returns
        #
        # Returns an array of all available instance sizes
        #
        #>> compute.flavors.all
        #  <Fog::BT::Compute::Flavors
        #    [
        #      <Fog::BT::Compute::Flavor
        #        id="m1.small",
        #        cores=1,
        #        diskSizeInGB=10,
        #        memorySizeInMB=512,
        #        name="Small"
        #      >,
        #      <Fog::BT::Compute::Flavor
        #        id="c1.medium",
        #        cores=1,
        #        diskSizeInGB=15,
        #        memorySizeInMB=1024,
        #        name="Medium"
        #      >
        #    ]
        #  >
        #

        def all
          data = [
            {:id =>  'm1.small',   :cores => 1, :diskSizeInGB => 10, :memorySizeInMB =>   512, :name => 'Small'},
            {:id =>  'c1.medium',  :cores => 1, :diskSizeInGB => 15, :memorySizeInMB =>  1024, :name => 'Medium'},
            {:id =>  'm1.large',   :cores => 2, :diskSizeInGB => 15, :memorySizeInMB =>  1024, :name => 'Large'},
            {:id =>  'm1.xlarge',  :cores => 2, :diskSizeInGB => 20, :memorySizeInMB =>  1024, :name => 'Extra Large'},
            {:id =>  'c1.xlarge',  :cores => 4, :diskSizeInGB => 20, :memorySizeInMB =>  2048, :name => 'High-CPU Extra Large'},
            {:id =>  'c1.xxlarge', :cores => 8, :diskSizeInGB => 30, :memorySizeInMB =>  4096, :name => 'High Memory Double Extra Large'},
            {:id =>  'm1.xxlarge', :cores => 8, :diskSizeInGB => 30, :memorySizeInMB =>  8192, :name => 'Double High Memory Double Extra Large'}
          ]
          load(data)
          self
        end

        # Used to retreive a flavor
        # flavor_id is required to get the associated flavor information.
        # flavors available currently:
        # 'm1.small', 'c1.medium', 'm1.large', 'm1.xlarge', 'c1.xlarge', 'c1.xxlarge', 'm1.xxlarge'
        #
        # You can run the following command to get the details:
        # compute.flavors.get("m1.small")
        #
        # ==== Returns
        #
        # <Fog::BT::Compute::Flavor
        #  id="m1.small",
        #  cores=1,
        #  diskSizeInGB=10,
        #  memorySizeInMB=512,
        #  name="Small"
        #> 
        #
        def get(flavor_id)
          self.class.new(:connection => connection).all.detect { |flavor| flavor.id == flavor_id }
        end

      end

    end
  end
end

