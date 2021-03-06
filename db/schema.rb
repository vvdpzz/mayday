# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110224151857) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "body"
    t.text     "body_markdown"
    t.string   "excerpt"
    t.boolean  "anonymous",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "brainstorms", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.text     "body_markdown"
    t.boolean  "anonymous",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brainstorms", ["user_id"], :name => "index_brainstorms_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "dude"
    t.integer  "dude_id"
    t.string   "did_what"
    t.string   "able"
    t.integer  "able_id"
    t.string   "excerpt"
    t.boolean  "status",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.text     "more"
    t.text     "body_markdown"
    t.text     "more_markdown"
    t.text     "excerpt"
    t.string   "status",             :default => "unanswered"
    t.integer  "reward",             :default => 0
    t.integer  "cost",               :default => 0
    t.integer  "amount_sum",         :default => 0
    t.integer  "history_max",        :default => 0
    t.boolean  "anonymous",          :default => false
    t.integer  "accepted_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answers_count"
    t.integer  "ans_user_id"
    t.string   "answer_user"
    t.string   "last_answer"
    t.string   "topics"
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "records", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "iotype"
    t.integer  "amount"
    t.string   "payee"
    t.integer  "payee_id"
    t.string   "payer"
    t.integer  "payer_id"
    t.string   "caption"
    t.string   "remark"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "headline"
    t.integer  "money",                               :default => 0
    t.integer  "brainstorms_count"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
