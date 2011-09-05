require 'chef/rest'
require 'chef/node'
require 'chef/knife'
require 'chef/config'
require 'tempfile'

class ChefApi < Chef::Knife

  def initialize account_details
    key_file = Tempfile.new("key")
    key_file.write account_details.chef_server_key
    key_file.close
    Chef::Config[:client_key] = key_file.path
    Chef::Config[:node_name] = 'Joe'
    Chef::Config[:chef_server_url] = 'http://109.144.14.214:4000' # testing
    @rest = Chef::REST.new(Chef::Config[:chef_server_url])
    super()
  end

  def roles_for_server server_id
    rest.get_rest("/nodes/#{server_id}").roles
  end
end
