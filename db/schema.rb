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

ActiveRecord::Schema[7.2].define(version: 2024_08_20_054357) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "day_schedules", force: :cascade do |t|
    t.bigint "week_schedule_id", null: false
    t.bigint "day_id", null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_day_schedules_on_day_id"
    t.index ["week_schedule_id"], name: "index_day_schedules_on_week_schedule_id"
  end

  create_table "days", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_days_on_name", unique: true
    t.index ["order"], name: "index_days_on_order", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_employees_on_name", unique: true
  end

  create_table "week_schedules", force: :cascade do |t|
    t.integer "week_number", null: false
    t.integer "year", null: false
    t.string "type", null: false
    t.string "owner_type", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_week_schedules_on_owner"
  end

  add_foreign_key "day_schedules", "days"
  add_foreign_key "day_schedules", "week_schedules"
end
