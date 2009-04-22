class AuthCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :name
      t.string   :email, :null => false, :limit => 100
      t.string   :crypted_password, :null => false, :limit => 128
      t.string   :password_salt, :null => false, :limit => 20
      t.string   :persistence_token, :limit => 128
      t.string   :single_access_token, :limit => 20
      t.string   :perishable_token, :limit =>  20
      t.integer  :login_count
      #t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string   :current_login_ip, :limit => 15
      t.string   :last_login_ip, :limit => 15

      t.boolean  :is_admin
      t.boolean  :pending

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :persistence_token
    add_index :users, :perishable_token
    add_index :users, :single_access_token
  end

  def self.down
    drop_table :users
  end
end
