class BetterUsers < ActiveRecord::Migration
  def up
    remove_column :users, :auth_hash
    add_column :users, :username, :string, :null => false
    add_column :users, :password_digest, :string, :null => false

    add_index :users, :username, :unique => true
  end

  def down
    add_column :users, :auth_hash, :string

    remove_column :users, :username
    remove_column :users, :password_digest
  end
end
