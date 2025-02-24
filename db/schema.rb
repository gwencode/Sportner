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

ActiveRecord::Schema[7.0].define(version: 2022_12_08_093759) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_chatrooms_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_type"
    t.string "name"
    t.datetime "date"
    t.text "description"
    t.integer "max_people"
    t.string "meeting_point"
    t.boolean "car_pooling", default: false
    t.integer "passengers", default: 0
    t.bigint "user_id", null: false
    t.bigint "spot_id"
    t.bigint "run_detail_id"
    t.string "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rating"
    t.float "latitude"
    t.float "longitude"
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
    t.float "latitude"
    t.float "longitude"
    t.bigint "spot_id"
    t.index ["spot_id"], name: "index_favorite_spots_on_spot_id"
    t.index ["user_id"], name: "index_favorite_spots_on_user_id"
  end

  create_table "itineraries", force: :cascade do |t|
    t.text "data"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_itineraries_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "meteos", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "report_datetime"
    t.string "weather"
    t.float "temperature"
    t.integer "wind_km"
    t.integer "wind_kt"
    t.integer "wind_direction"
    t.float "wave_height"
    t.integer "wave_period"
    t.integer "wave_direction"
    t.integer "sea_temperature"
    t.integer "coef"
    t.string "previous_tide_type"
    t.time "previous_tide_time"
    t.string "next_tide_type"
    t.time "next_tide_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_meteos_on_event_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating_event"
    t.integer "rating_difficulty"
    t.integer "rating_spot"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reviews_on_event_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "run_details", force: :cascade do |t|
    t.string "run_type"
    t.float "distance"
    t.string "pace"
    t.integer "duration"
    t.integer "elevation"
    t.string "location"
    t.text "live_itinerary"
    t.bigint "itinerary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rating"
    t.float "latitude"
    t.float "longitude"
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
    t.float "rating"
    t.float "latitude"
    t.float "longitude"
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
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chatrooms", "events"
  add_foreign_key "events", "run_details"
  add_foreign_key "events", "spots"
  add_foreign_key "events", "users"
  add_foreign_key "favorite_spots", "spots"
  add_foreign_key "favorite_spots", "users"
  add_foreign_key "itineraries", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "meteos", "events"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
  add_foreign_key "reviews", "events"
  add_foreign_key "reviews", "users"
  add_foreign_key "run_details", "itineraries"
end
