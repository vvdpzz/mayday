class AddLastAnswerToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :ans_user_id, :integer
    add_column :questions, :answer_user, :string
    add_column :questions, :last_answer, :string
  end

  def self.down
    remove_column :questions, :ans_user_id
    remove_column :questions, :answer_user
    remove_column :questions, :last_answer
  end
end
