class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.references :user
      t.text :body
      t.text :more
      t.text :body_markdown
      t.text :more_markdown
      t.text :excerpt
      
      t.string :status, :default => "unanswered"
      
      t.integer :reward, :default => 0
      t.integer :cost, :default => 0
      t.integer :amount_sum, :default => 0
      t.integer :history_max, :default => 0
      
      t.boolean :anonymous, :default => false
      
      t.integer :accepted_answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
