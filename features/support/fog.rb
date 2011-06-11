require 'fog'
Fog.mock!
@bt = Fog::Compute.new :provider => 'BT'
