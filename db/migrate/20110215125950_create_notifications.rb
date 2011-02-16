class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :user
      t.string :dude
      t.integer :dude_id
      t.string :did_what
      t.string :able
      t.integer :able_id
      t.string :excerpt
      t.boolean :status, :default => false

      t.timestamps
    end
    add_index :notifications, :user_id
  end

  def self.down
    drop_table :notifications
  end
end
