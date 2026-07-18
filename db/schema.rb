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

ActiveRecord::Schema[8.1].define(version: 2026_07_17_194232) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exercise_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "exercise_id", null: false
    t.datetime "updated_at", null: false
    t.integer "workout_id", null: false
    t.index ["exercise_id"], name: "index_exercise_logs_on_exercise_id"
    t.index ["workout_id"], name: "index_exercise_logs_on_workout_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_sets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "exercise_log_id", null: false
    t.integer "reps"
    t.integer "set_number"
    t.datetime "updated_at", null: false
    t.decimal "weight"
    t.index ["exercise_log_id"], name: "index_workout_sets_on_exercise_log_id"
  end

  create_table "workout_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date"
    t.text "notes"
    t.datetime "updated_at", null: false
    t.integer "workout_type_id", null: false
    t.index ["workout_type_id"], name: "index_workouts_on_workout_type_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "exercise_logs", "exercises"
  add_foreign_key "exercise_logs", "workouts"
  add_foreign_key "workout_sets", "exercise_logs"
  add_foreign_key "workouts", "workout_types"
end
