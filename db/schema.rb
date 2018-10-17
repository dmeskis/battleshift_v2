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

ActiveRecord::Schema.define(version: 20181014195255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.text "player_1_board"
    t.text "player_2_board"
    t.string "winner"
    t.integer "player_1_turns"
    t.integer "player_2_turns"
    t.integer "current_turn"
    t.bigint "challenger_id"
    t.bigint "opponent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenger_id"], name: "index_games_on_challenger_id"
    t.index ["opponent_id"], name: "index_games_on_opponent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "password_digest"
    t.integer "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activation_token"
    t.string "activation_digest"
    t.integer "activated", default: 0
    t.datetime "activated_at"
    t.string "api_key"
  end

  add_foreign_key "games", "users", column: "challenger_id"
  add_foreign_key "games", "users", column: "opponent_id"
end
