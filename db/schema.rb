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

ActiveRecord::Schema.define(version: 2020_11_03_203609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "lg_account_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "lg_agency_id"
    t.string "iaa_7600b"
    t.date "iaa_7600b_start"
    t.date "iaa_7600b_end"
    t.integer "iaa_7600b_amount"
    t.integer "iaa_7600b_billed"
    t.integer "pricing"
    t.integer "ial1_users_in_pop"
    t.integer "ial2_users_in_pop"
    t.date "became_partner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "agencies", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "apps", force: :cascade do |t|
    t.bigint "account_id"
    t.string "lg_app_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "ial", null: false
    t.text "lg_client_ids", default: [], array: true
    t.string "identity_protocol"
    t.date "certificate_expiration"
    t.boolean "approved", default: false, null: false
    t.boolean "live", default: false, null: false
    t.date "live_on"
    t.string "url"
    t.integer "users_in_pop"
    t.integer "users_lifetime"
    t.integer "auths_in_pop"
    t.integer "auths_lifetime"
    t.integer "ial2_users_in_pop"
    t.integer "ial2_users_lifetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_apps_on_account_id"
  end

  create_table "iaa_gtcs", force: :cascade do |t|
    t.string "gtc_number", null: false
    t.date "start_date"
    t.date "end_date"
    t.date "signed_date"
    t.integer "estimated_amount"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mod_number", default: 0, null: false
    t.index ["account_id"], name: "index_iaa_gtcs_on_account_id"
    t.index ["gtc_number"], name: "index_iaa_gtcs_on_gtc_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "account_id"
    t.string "uuid"
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone"
    t.string "lg_account_id"
    t.string "lg_agency_id"
    t.boolean "admin", default: false, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "iaa_gtcs", "accounts"
end
