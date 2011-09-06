require 'fog/core/model'

module Fog
  module BT
    class Compute

      class Flavor < Fog::Model

        identity :id

        attribute :cores
        attribute :diskSizeInGB
        attribute :memorySizeInMB
        attribute :name

      end

    end
  end
end
