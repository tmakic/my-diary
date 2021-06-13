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

ActiveRecord::Schema.define(version: 2021_06_13_080318) do

  create_table "event_exercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_exercises_on_event_id"
    t.index ["exercise_id"], name: "index_event_exercises_on_exercise_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title"
    t.text "memo"
    t.datetime "start_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "done"
    t.text "achievement"
    t.text "exercise"
    t.boolean "exercise_upper_arms", default: false
    t.boolean "exercise_abs", default: false
    t.boolean "exercise_hamstrings", default: false
    t.boolean "exercise_legs", default: false
  end

  create_table "exercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "label"
    t.string "name"
  end

  add_foreign_key "event_exercises", "events"
  add_foreign_key "event_exercises", "exercises"
end
