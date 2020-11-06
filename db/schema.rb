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

ActiveRecord::Schema.define(version: 2020_11_06_044644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "account_contacts", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "user_id"], name: "index_account_contacts_on_account_id_and_user_id", unique: true
    t.index ["account_id"], name: "index_account_contacts_on_account_id"
    t.index ["user_id"], name: "index_account_contacts_on_user_id"
  end

  create_table "account_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_account_statuses_on_name", unique: true
    t.index ["order"], name: "index_account_statuses_on_order", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "lg_account_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "lg_agency_id"
    t.integer "pricing"
    t.date "became_partner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_status_id"
    t.index ["account_status_id"], name: "index_accounts_on_account_status_id"
  end

  create_table "agencies", force: :cascade do |t|
    t.string "name", null: false
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
    t.bigint "iaa_status_id"
    t.index ["account_id"], name: "index_iaa_gtcs_on_account_id"
    t.index ["gtc_number"], name: "index_iaa_gtcs_on_gtc_number", unique: true
    t.index ["iaa_status_id"], name: "index_iaa_gtcs_on_iaa_status_id"
  end

  create_table "iaa_orders", force: :cascade do |t|
    t.integer "order_number", null: false
    t.integer "mod_number", default: 0, null: false
    t.date "start_date"
    t.date "end_date"
    t.date "signed_date"
    t.integer "estimated_amount"
    t.integer "billed_amount"
    t.bigint "iaa_gtc_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "iaa_status_id"
    t.index ["iaa_gtc_id", "order_number"], name: "index_iaa_orders_on_iaa_gtc_id_and_order_number", unique: true
    t.index ["iaa_gtc_id"], name: "index_iaa_orders_on_iaa_gtc_id"
    t.index ["iaa_status_id"], name: "index_iaa_orders_on_iaa_status_id"
  end

  create_table "iaa_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_iaa_statuses_on_name", unique: true
    t.index ["order"], name: "index_iaa_statuses_on_order", unique: true
  end

  create_table "integration_contacts", force: :cascade do |t|
    t.bigint "integration_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["integration_id", "user_id"], name: "index_integration_contacts_on_integration_id_and_user_id", unique: true
    t.index ["integration_id"], name: "index_integration_contacts_on_integration_id"
    t.index ["user_id"], name: "index_integration_contacts_on_user_id"
  end

  create_table "integration_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_integration_statuses_on_name", unique: true
    t.index ["order"], name: "index_integration_statuses_on_order", unique: true
  end

  create_table "integrations", force: :cascade do |t|
    t.string "issuer", null: false
    t.string "name", null: false
    t.text "description"
    t.string "dashboard_url"
    t.boolean "ial2", default: false, null: false
    t.string "protocol", default: "oidc", null: false
    t.string "url"
    t.date "go_live"
    t.date "prod_deploy"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "integration_status_id"
    t.index ["account_id"], name: "index_integrations_on_account_id"
    t.index ["integration_status_id"], name: "index_integrations_on_integration_status_id"
    t.index ["issuer"], name: "index_integrations_on_issuer", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone"
    t.boolean "admin", default: false, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.uuid "uuid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "account_contacts", "accounts"
  add_foreign_key "account_contacts", "users"
  add_foreign_key "accounts", "account_statuses"
  add_foreign_key "iaa_gtcs", "accounts"
  add_foreign_key "iaa_gtcs", "iaa_statuses"
  add_foreign_key "iaa_orders", "iaa_gtcs"
  add_foreign_key "iaa_orders", "iaa_statuses"
  add_foreign_key "integration_contacts", "integrations"
  add_foreign_key "integration_contacts", "users"
  add_foreign_key "integrations", "accounts"
  add_foreign_key "integrations", "integration_statuses"
end
