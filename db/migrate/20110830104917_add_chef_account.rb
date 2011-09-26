class AddChefAccount < ActiveRecord::Migration
  def self.up
    create_table :chef_api_accounts do |t|
      t.string     :label,                   :null => false
      t.string     :chef_username,           :null => false
      t.string     :chef_server_url,         :null => false
      t.text       :chef_server_key,         :null => false
      t.integer    :user_id
    end
  end

  def self.down
    drop_table :chef_api_accounts
  end
end
