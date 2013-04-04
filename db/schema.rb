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

ActiveRecord::Schema.define(:version => 20130331042814) do

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employee_current_skills", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "skill_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "skill_level"
  end

  create_table "employee_desired_skills", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "skill_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "interest_level"
  end

  create_table "employees", :force => true do |t|
    t.decimal  "years_with_company"
    t.string   "manager"
    t.string   "position"
    t.string   "department"
    t.string   "group"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "about_me"
    t.string   "image"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.integer  "location_id"
    t.integer  "group_id"
    t.integer  "department_id"
    t.integer  "position_id"
  end

  add_index "employees", ["remember_token"], :name => "index_employees_on_remember_token"

  create_table "groups", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "request_skills", :force => true do |t|
    t.integer  "skill_id"
    t.integer  "request_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "employee_id"
    t.string   "task"
    t.string   "location"
    t.string   "group"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title"
    t.integer  "location_id"
    t.integer  "group_id"
  end

  create_table "responses", :force => true do |t|
    t.integer  "request_id"
    t.integer  "employee_id"
    t.string   "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "status"
  end

  create_table "selections", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "request_id"
    t.integer  "response_id"
    t.string   "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
