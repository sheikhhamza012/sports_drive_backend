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

ActiveRecord::Schema.define(version: 2021_02_14_162059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arena_booking_requests", force: :cascade do |t|
    t.datetime "from_time"
    t.datetime "to_time"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price", default: 0
    t.bigint "field_id"
    t.index ["field_id"], name: "index_arena_booking_requests_on_field_id"
    t.index ["user_id"], name: "index_arena_booking_requests_on_user_id"
  end

  create_table "arenas", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.jsonb "location", default: {}
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rating", default: 0
    t.index ["user_id"], name: "index_arenas_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "fcm_token"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "field_type"
    t.string "image"
    t.bigint "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["group_id"], name: "index_fields_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "capacity"
    t.string "name"
    t.bigint "arena_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "allow_instant_booking", default: false
    t.index ["arena_id"], name: "index_groups_on_arena_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "priceable_id"
    t.string "priceable_type"
    t.string "name"
    t.date "date"
    t.time "from_time"
    t.time "to_time"
    t.integer "price"
    t.integer "price_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "no_of_players"
    t.string "city"
    t.string "image"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "phone"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name"
    t.boolean "isVendor", default: false
    t.string "about"
    t.string "featured"
    t.integer "player_of"
    t.integer "rating", default: 0
    t.string "image"
    t.bigint "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "vendor_details", force: :cascade do |t|
    t.bigint "user_id"
    t.string "id_card"
    t.integer "request_status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "commission", default: "0.0"
    t.index ["user_id"], name: "index_vendor_details_on_user_id"
  end

end
