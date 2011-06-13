class Cloud
  def self.set_mock_images images
    Fog::BT::Compute::Mock.data[:images] = images
    connection.instance_variable_set(:@data, Fog::BT::Compute::Mock.data)
  end

  def self.images
    connection.images
  end

  private

  def self.connection
    @@connection ||= Fog::Compute.new :provider => 'BT' 
  end

end
