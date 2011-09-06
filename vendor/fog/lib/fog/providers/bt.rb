require 'fog/core'
require 'fog/core/parser'

module Fog
  module BT

    extend Fog::Provider

    service(:compute,   'compute/bt')

    #class Mock

      #def self.availability_zone
        #"us-east-1" << Fog::Mock.random_selection('abcd', 1)
      #end
    #end
  end
end
