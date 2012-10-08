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

ActiveRecord::Schema.define(:version => 20121008045451) do

  create_table "bookmarks", :force => true do |t|
    t.string   "url",           :null => false
    t.integer  "popularity",    :null => false
    t.integer  "security",      :null => false
    t.integer  "categories_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "bookmarks", ["url"], :name => "index_bookmarks_on_url", :unique => true

  create_table "bookmarks_denunces", :force => true do |t|
    t.integer  "denunces_id",                  :null => false
    t.integer  "bookmarks_id",                 :null => false
    t.string   "message",      :default => "", :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "denunces", :force => true do |t|
    t.string   "type",                        :null => false
    t.string   "description", :default => "", :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "denunces", ["type", "description"], :name => "index_denunces_on_type_and_description", :unique => true

  create_table "user_bookmarks", :force => true do |t|
    t.integer  "users_id"
    t.integer  "bookmarks_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "user_bookmarks", ["users_id", "bookmarks_id"], :name => "index_user_bookmarks_on_users_id_and_bookmarks_id", :unique => true

  create_table "users", :force => true do |t|
    t.boolean  "admin",                  :default => false, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username",                                  :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
