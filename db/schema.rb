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

ActiveRecord::Schema.define(:version => 20131209231525) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "where"
    t.datetime "event_time"
    t.integer  "people_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "google_id"
    t.string   "uid"
  end

  create_table "events_people", :force => true do |t|
    t.integer "event_id"
    t.integer "person_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups_people", :force => true do |t|
    t.integer "group_id"
    t.integer "person_id"
  end

  create_table "org_units", :force => true do |t|
    t.string   "org_node"
    t.string   "org_node_description"
    t.integer  "level"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "progress"
    t.boolean  "favorite"
    t.integer  "events_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email"
    t.boolean  "active",                 :default => false
    t.boolean  "is_linkedin_connection", :default => false
    t.string   "phone_number"
    t.string   "cal_net_dept_name"
    t.string   "hr_dept_name"
    t.string   "job_title"
    t.string   "room_number"
    t.string   "building"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "token_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
