class Cloud
  def initialize cloud_account_credentials
    @provider             = cloud_account_credentials[:provider]
    @region               = cloud_account_credentials[:region]
    @bt_access_key_id     = cloud_account_credentials[:ec2_access_key]
    @bt_secret_access_key = cloud_account_credentials[:ec2_secret_key]
    @connection = connection
  end

  def images
    connection.images.select{|i| i.type == "MACHINE"}
  end

  def connection
    @connection ||= Fog::Compute.new( :provider => @provider,
                      :region                   => @region,
                      :bt_access_key_id         => @bt_access_key_id,
                      :bt_secret_access_key     => @bt_secret_access_key)
  end

  def servers
    connection.servers
  end

  def start_server image_id
    connection.servers.create( :image_id => image_id)
  end

end
