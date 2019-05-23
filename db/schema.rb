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

ActiveRecord::Schema.define(version: 2019_05_23_110201) do

  create_table "contributions", force: :cascade do |t|
    t.integer "coffee_taste"
    t.integer "food_variation"
    t.integer "for_working"
    t.string "text"
    t.string "image"
    t.integer "wifi"
    t.integer "charger"
    t.string "shopname"
    t.integer "user_id"
    t.boolean "laidback"
    t.boolean "dark"
    t.boolean "light"
    t.boolean "lively"
    t.boolean "quiet"
    t.boolean "station"
    t.boolean "bitwalk"
    t.boolean "farsta"
    t.boolean "hidden"
    t.boolean "town"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contribution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "mail"
    t.string "password_digest"
    t.string "user_name"
    t.string "profile_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
