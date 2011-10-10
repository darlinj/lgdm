require 'chef/rest'
require 'chef/node'
require 'chef/knife'
require 'chef/config'
require 'tempfile'
require 'yajl/json_gem'

class ChefApi < Chef::Knife

  def initialize account_details
    if account_details
      key_file = Tempfile.new("key", "#{Rails.root}/tmp/")
      key_file.write account_details.chef_server_key
      key_file.close
      Chef::Config[:client_key] = key_file.path
      Chef::Config[:node_name] = account_details.chef_username
      Chef::Config[:chef_server_url] = account_details.chef_server_url
      @rest = Chef::REST.new(Chef::Config[:chef_server_url])
      super()
    end
  end

  def roles_for_server server_id
    response = Chef::Node.json_create(rest.get_rest("/nodes/#{server_id}"))
    response.attribute?(:roles) ? response.roles : []
  rescue Net::HTTPServerException => e
    return [] if e.response.code == "404"
    return "Unable to get chef data" if e.response.code == "401"
  end
end
