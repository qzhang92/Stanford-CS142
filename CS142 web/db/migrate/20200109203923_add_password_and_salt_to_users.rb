class AddPasswordAndSaltToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :hashed_password, :string
    add_column :users, :salt, :string
  end

  def self.down
    remove_column :users, :salt
    remove_column :users, :hashed_password
  end
end
