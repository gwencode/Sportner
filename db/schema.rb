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

ActiveRecord::Schema[7.0].define(version: 2022_11_29_143628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "event_type"
    t.string "name"
    t.datetime "date"
    t.text "description"
    t.integer "max_people"
    t.string "meeting_point"
    t.boolean "car_pooling", default: false
    t.integer "passengers", default: 3
    t.bigint "user_id", null: false
    t.bigint "spot_id"
    t.bigint "run_detail_id"
    t.string "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_detail_id"], name: "index_events_on_run_detail_id"
    t.index ["spot_id"], name: "index_events_on_spot_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "favorite_spots", force: :cascade do |t|
    t.string "sport"
    t.string "city_spot"
    t.integer "radius", default: 1, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorite_spots_on_user_id"
  end

  create_table "itineraries", force: :cascade do |t|
    t.text "data"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_itineraries_on_user_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "run_details", force: :cascade do |t|
    t.string "type"
    t.float "distance"
    t.string "pace"
    t.integer "duration"
    t.integer "elevation"
    t.string "location"
    t.text "live_itinerary"
    t.bigint "itinerary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itinerary_id"], name: "index_run_details_on_itinerary_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "location"
    t.string "spot_difficulty"
    t.string "wave_type"
    t.string "wave_direction"
    t.string "bottom"
    t.string "wave_height_infos"
    t.string "tide_conditions"
    t.string "danger"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "runner", default: false
    t.boolean "surfer", default: false
    t.string "address", default: "", null: false
    t.date "birthday"
    t.string "run_level", default: "débutant", null: false
    t.string "surf_level", default: "débutant", null: false
    t.integer "run_xp", default: 0, null: false
    t.integer "surf_xp", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zipcode", default: "", null: false
    t.string "city", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "run_details"
  add_foreign_key "events", "spots"
  add_foreign_key "events", "users"
  add_foreign_key "favorite_spots", "users"
  add_foreign_key "itineraries", "users"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
  add_foreign_key "run_details", "itineraries"
end
