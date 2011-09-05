class Server

  attr_accessor :id, :dns_name, :image_id, :key_name, :groups, :state, :roles

  def initialize(server = nil)
    if server
      self.id = server.id
      self.dns_name     = server.dns_name
      self.image_id     = server.image_id
      self.key_name     = server.key_name
      self.groups       = server.groups
      self.state        = server.state
    end
  end

  def self.all(cloud, chef=nil)
    servers = cloud.servers.map {|server| self.new(server)}
    if chef
      servers = servers.each do |server|
        server.roles = chef.roles_for_server( server.id )
      end
    end
    servers
  end
end
