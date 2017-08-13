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

ActiveRecord::Schema.define(version: 20170813014738) do

  create_table "activity_records", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "note",       limit: 255
    t.string   "user_ip",    limit: 255
    t.string   "browser",    limit: 255
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.text     "params",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "post_buys", force: :cascade do |t|
    t.date    "date"
    t.string  "channel",       limit: 255
    t.string  "program",       limit: 255
    t.string  "level_1",       limit: 255
    t.string  "level_2",       limit: 255
    t.string  "sector",        limit: 255
    t.string  "category",      limit: 255
    t.string  "advertiser",    limit: 255
    t.string  "product",       limit: 255
    t.string  "copy",          limit: 255
    t.time    "start_time"
    t.time    "end_time"
    t.time    "duration"
    t.integer "break_no",      limit: 4
    t.integer "pos_in_vreak",  limit: 4
    t.integer "tot_spots_in",  limit: 4
    t.string  "spot_type",     limit: 255
    t.string  "size",          limit: 255
    t.integer "cost",          limit: 4
    t.integer "t_second_cost", limit: 4
    t.time    "st_video"
    t.time    "et_video"
  end

  create_table "television_programs", force: :cascade do |t|
    t.date    "date"
    t.string  "channel",    limit: 255
    t.string  "program",    limit: 255
    t.string  "level_1",    limit: 255
    t.string  "level_2",    limit: 255
    t.time    "start_time"
    t.time    "end_time"
    t.time    "duration"
    t.string  "size",       limit: 255
    t.integer "cost",       limit: 4
    t.time    "st_video"
    t.time    "et_video"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "viewers", force: :cascade do |t|
    t.string  "market",               limit: 255
    t.string  "activity",             limit: 255
    t.string  "target",               limit: 255
    t.date    "date"
    t.string  "channel",              limit: 255
    t.string  "day_part_or_variable", limit: 255
    t.float   "tVR",                  limit: 24
    t.float   "share",                limit: 24
    t.integer "000s",                 limit: 4
    t.date    "index"
  end

end
