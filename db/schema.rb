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

ActiveRecord::Schema[7.1].define(version: 2025_12_28_050658) do
  create_table "bicycle_registrations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resident_id", null: false
    t.string "registration_number", null: false
    t.integer "bicycle_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registration_number"], name: "index_bicycle_registrations_on_registration_number", unique: true
    t.index ["resident_id"], name: "index_bicycle_registrations_on_resident_id"
  end

  create_table "contracts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resident_id", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.string "guarantor_name"
    t.string "guarantor_phone"
    t.string "guarantor_address"
    t.integer "deposit", default: 0
    t.integer "key_money", default: 0
    t.integer "deposit_returned"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_contracts_on_resident_id"
  end

  create_table "incidents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resident_id", null: false
    t.bigint "room_id"
    t.string "incident_type", default: "other", null: false
    t.string "title", null: false
    t.text "description"
    t.date "occurred_on", null: false
    t.date "resolved_on"
    t.string "status", default: "open", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_incidents_on_resident_id"
    t.index ["room_id"], name: "index_incidents_on_room_id"
  end

  create_table "maintenance_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.string "title", null: false
    t.text "description"
    t.date "performed_on", null: false
    t.integer "cost", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_maintenance_records_on_room_id"
  end

  create_table "motorcycle_registrations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resident_id", null: false
    t.string "registration_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registration_number"], name: "index_motorcycle_registrations_on_registration_number", unique: true
    t.index ["resident_id"], name: "index_motorcycle_registrations_on_resident_id"
  end

  create_table "parking_spaces", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "space_number", null: false
    t.string "user_type", default: "resident", null: false
    t.bigint "resident_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_parking_spaces_on_resident_id"
    t.index ["space_number"], name: "index_parking_spaces_on_space_number", unique: true
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resident_id", null: false
    t.string "year_month", null: false
    t.integer "amount", null: false
    t.date "paid_on"
    t.string "status", default: "unpaid", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id", "year_month"], name: "index_payments_on_resident_id_and_year_month", unique: true
    t.index ["resident_id"], name: "index_payments_on_resident_id"
  end

  create_table "rent_histories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.integer "rent", null: false
    t.date "started_on", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_rent_histories_on_room_id"
  end

  create_table "residents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.string "emergency_contact"
    t.date "move_in_date", null: false
    t.date "move_out_date"
    t.boolean "has_pet", default: false
    t.string "pet_details"
    t.integer "occupants_count", default: 1
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_residents_on_room_id"
  end

  create_table "room_photos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.string "photo_type", null: false
    t.date "taken_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_photos_on_room_id"
  end

  create_table "room_vacancies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.date "vacant_from", null: false
    t.date "vacant_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_vacancies_on_room_id"
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "room_number", null: false
    t.string "floor_plan"
    t.integer "rent"
    t.string "status", default: "vacant", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_number"], name: "index_rooms_on_room_number", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "role", default: "staff", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vehicles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resident_id", null: false
    t.string "vehicle_type", null: false
    t.string "make_model"
    t.string "plate_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_vehicles_on_resident_id"
  end

  add_foreign_key "bicycle_registrations", "residents"
  add_foreign_key "contracts", "residents"
  add_foreign_key "incidents", "residents"
  add_foreign_key "incidents", "rooms"
  add_foreign_key "maintenance_records", "rooms"
  add_foreign_key "motorcycle_registrations", "residents"
  add_foreign_key "parking_spaces", "residents"
  add_foreign_key "payments", "residents"
  add_foreign_key "rent_histories", "rooms"
  add_foreign_key "residents", "rooms"
  add_foreign_key "room_photos", "rooms"
  add_foreign_key "room_vacancies", "rooms"
  add_foreign_key "vehicles", "residents"
end
