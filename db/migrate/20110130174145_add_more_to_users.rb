class AddMoreToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :headline, :string, :default => ""
    add_column :users, :money, :integer, :default => 0
  end

  def self.down
    remove_column :users, :money
    remove_column :users, :headline
    remove_column :users, :name
  end
end
