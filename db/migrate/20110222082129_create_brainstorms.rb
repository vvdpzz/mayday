class CreateBrainstorms < ActiveRecord::Migration
  def self.up
    create_table :brainstorms do |t|
      t.references :user
      t.text :body
      t.text :body_markdown
      t.boolean :anonymous, :default => false

      t.timestamps
    end
    add_index :brainstorms, :user_id
  end

  def self.down
    drop_table :brainstorms
  end
end
