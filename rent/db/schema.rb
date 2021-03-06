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

ActiveRecord::Schema.define(:version => 20111006230144) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", :force => true do |t|
    t.string   "address"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "call_logs", :force => true do |t|
    t.integer  "cid_id"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cids", :force => true do |t|
    t.string   "number"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "comment"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dids", :force => true do |t|
    t.integer  "provider_id"
    t.string   "number"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.string   "gist"
    t.string   "pitch"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit"
    t.integer  "building_id"
    t.integer  "listings_type_id"
    t.integer  "room_config_id"
    t.integer  "fee_type_id"
    t.integer  "monthly_rent"
    t.integer  "created_by_id"
    t.integer  "rooms_total"
    t.integer  "rooms_bed"
    t.integer  "rooms_bath"
  end

  create_table "roles", :force => true do |t|
    t.string   "rolename"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "selections", :force => true do |t|
    t.string   "name"
    t.integer  "created_by_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.string   "ns"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                     :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.integer  "role_id"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
