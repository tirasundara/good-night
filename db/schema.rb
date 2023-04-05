# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_04_041257) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sleep_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "sleep_time_id"
    t.bigint "wake_up_time_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sleep_time_id"], name: "index_sleep_records_on_sleep_time_id"
    t.index ["user_id"], name: "index_sleep_records_on_user_id"
    t.index ["wake_up_time_id"], name: "index_sleep_records_on_wake_up_time_id"
  end

  create_table "sleep_times", force: :cascade do |t|
    t.datetime "sleep_ts", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_follows", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wake_up_times", force: :cascade do |t|
    t.datetime "wake_up_ts", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sleep_records", "sleep_times"
  add_foreign_key "sleep_records", "users"
  add_foreign_key "sleep_records", "wake_up_times"
end
