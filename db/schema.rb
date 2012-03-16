# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120316042908) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "content",    :limit => 255
    t.string   "label"
    t.string   "video_id"
    t.integer  "video_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "video_end"
    t.text     "item_info"
    t.integer  "lecture_id"
  end

  create_table "lectures", :force => true do |t|
    t.string   "title"
    t.string   "video_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memories", :force => true do |t|
    t.integer  "learner_id"
    t.string   "learner_type"
    t.integer  "component_id"
    t.string   "component_type"
    t.decimal  "ease",           :default => 2.5
    t.decimal  "interval",       :default => 1.0
    t.integer  "views",          :default => 0
    t.integer  "streak",         :default => 0
    t.datetime "last_viewed"
    t.datetime "due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memories", ["component_id"], :name => "index_memories_on_component_id"
  add_index "memories", ["learner_id", "component_id"], :name => "index_memories_on_learner_id_and_component_id", :unique => true
  add_index "memories", ["learner_id"], :name => "index_memories_on_learner_id"

  create_table "memory_ratings", :force => true do |t|
    t.integer  "memory_id"
    t.integer  "quality"
    t.integer  "streak"
    t.decimal  "ease"
    t.integer  "interval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memory_ratings", ["memory_id"], :name => "index_memory_ratings_on_memory_id"

  create_table "quizzes", :force => true do |t|
    t.text     "content"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizzes", ["item_id"], :name => "index_quizzes_on_item_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
