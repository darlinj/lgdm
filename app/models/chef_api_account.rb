class ChefApiAccount < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :label
  validates_presence_of :chef_server_url
  validates_presence_of :chef_server_key

end
