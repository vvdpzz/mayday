class AddBrainstormsCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :brainstorms_count, :integer
  end

  def self.down
    remove_column :users, :brainstorms_count
  end
end
