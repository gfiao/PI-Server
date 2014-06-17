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

ActiveRecord::Schema.define(version: 20140617153758) do

  create_table "bookmarked_contents", force: true do |t|
    t.integer  "user_id"
    t.integer  "content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classrooms", force: true do |t|
    t.string   "building"
    t.string   "classroom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_videos", force: true do |t|
    t.integer  "content_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.string   "title"
    t.string   "link_image"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views"
    t.text     "news_text"
    t.integer  "user_id"
  end

  create_table "current_videos", force: true do |t|
    t.integer  "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "footer_news", force: true do |t|
    t.string   "category"
    t.string   "news"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_classrooms", force: true do |t|
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.datetime "from_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes"
    t.datetime "to_time"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hours", force: true do |t|
    t.integer  "hour"
    t.integer  "minute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "meal"
    t.string   "dish"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "restaurant"
  end

  create_table "scores", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tag_contents", force: true do |t|
    t.integer  "content_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transport_hours", force: true do |t|
    t.integer  "transport_id"
    t.integer  "hour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transports", force: true do |t|
    t.integer  "carreira"
    t.string   "origin"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.date     "birth_date"
    t.string   "gender"
    t.string   "course"
    t.string   "about_me"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "videos", force: true do |t|
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weathers", force: true do |t|
    t.date     "date"
    t.integer  "min_temp"
    t.integer  "max_temp"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "image_url"
  end

end
