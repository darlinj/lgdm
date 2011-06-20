class Cloud
  def initialize credentials
    @provider             = credentials[:provider]
    @region               = credentials[:region]
    @bt_access_key_id     = credentials[:bt_access_key_id]
    @bt_secret_access_key = credentials[:bt_secret_access_key]
  end

  def images
    connection.images
  end

  def connection
    Fog::Compute.new( :provider               => @provider,
                      :region                 => @region,
                      :bt_access_key_id       => @bt_access_key_id,
                      :bt_secret_access_key   => @bt_secret_access_key)
  end

  def servers
    connection.servers
  end

  def run_image image_id
    connection.servers.create( :image_id => image_id)
  end

end
