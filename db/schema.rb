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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141023102518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deals", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deals", ["venue_id"], name: "index_deals_on_venue_id", using: :btree

  create_table "hours", force: true do |t|
    t.integer  "venue_id"
    t.integer  "day"
    t.time     "open_time"
    t.time     "close_time"
    t.boolean  "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hours", ["venue_id", "day"], name: "index_hours_on_venue_id_and_day", using: :btree
  add_index "hours", ["venue_id"], name: "index_hours_on_venue_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.boolean  "admin"
    t.string   "phone"
    t.string   "location"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "street"
    t.string   "suburb"
    t.string   "region"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "full_address"
    t.string   "state",        default: "NSW"
    t.string   "country",      default: "Australia"
  end

end
