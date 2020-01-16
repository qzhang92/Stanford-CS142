class AddLoginToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :login, :string, :limite => 18
  end

  def self.down
    remove_column :users, :login
  end
end
