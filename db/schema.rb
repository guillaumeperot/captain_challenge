# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_16_141507) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "health"
    t.integer "attack"
    t.integer "speed", default: 1
    t.integer "dodge_rate", default: 0
    t.integer "critical_rate", default: 0
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "power"
    t.integer "rank"
  end

  create_table "clash_events", force: :cascade do |t|
    t.integer "clash_id"
    t.string "attacker_name"
    t.integer "attack_type"
    t.integer "attack_damage"
    t.string "defender_name"
    t.integer "defend_type"
    t.integer "defender_health"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clash_id"], name: "index_clash_events_on_clash_id"
  end

  create_table "clashs", force: :cascade do |t|
    t.integer "winner_id"
    t.integer "loser_id"
    t.text "winner_attributes"
    t.text "loser_attributes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["loser_id"], name: "index_clashs_on_loser_id"
    t.index ["winner_id"], name: "index_clashs_on_winner_id"
  end

end
