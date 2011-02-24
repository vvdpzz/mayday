class AddTopicsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :topics, :string
  end

  def self.down
    remove_column :questions, :topics
  end
end
