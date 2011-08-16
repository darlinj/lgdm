class AddCloudAccounts < ActiveRecord::Migration
  def self.up
    create_table :cloud_accounts do |t|
      t.string     :label,            :null => false
      t.string     :provider,         :null => false
      t.string     :region,           :null => false
      t.string     :s3_url
      t.string     :ec2_url,          :null => false
      t.string     :ec2_access_key,   :null => false
      t.string     :ec2_secret_key,   :null => false
      t.integer    :user_id
    end
  end

  def self.down
    drop_table :cloud_accounts
  end
end
