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

ActiveRecord::Schema[7.0].define(version: 2023_02_14_095031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "days", force: :cascade do |t|
    t.date "date", null: false
    t.boolean "taken", default: false, null: false
    t.bigint "real_estate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_estate_id"], name: "index_days_on_real_estate_id"
  end

  create_table "real_estates", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "address"
    t.integer "estate_type", null: false
    t.integer "price", null: false
    t.bigint "host_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_real_estates_on_city_id"
    t.index ["host_id"], name: "index_real_estates_on_host_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "checkin", null: false
    t.date "checkout", null: false
    t.bigint "real_estate_id", null: false
    t.bigint "guest_id", null: false
    t.boolean "validated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["real_estate_id"], name: "index_reservations_on_real_estate_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "days", "real_estates"
  add_foreign_key "real_estates", "cities"
  add_foreign_key "real_estates", "users", column: "host_id"
  add_foreign_key "reservations", "real_estates"
  add_foreign_key "reservations", "users", column: "guest_id"
end
