require 'fog'
Fog.mock!

Before do
  Fog::BT::Compute::Mock.reset_data
end


