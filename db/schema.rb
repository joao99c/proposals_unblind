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

ActiveRecord::Schema[7.0].define(version: 2022_07_28_143645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "deal_status", ["lost", "open", "won"]
  create_enum "discount_type", ["none", "percent", "fixed", "free"]

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "responsable_name"
    t.string "responsable_email"
    t.text "website"
    t.text "responsable_tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deal_products", force: :cascade do |t|
    t.bigint "deal_id", null: false
    t.bigint "product_id", null: false
    t.decimal "discount_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.enum "discount_type", default: "none", null: false, enum_type: "discount_type"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_deal_products_on_deal_id"
    t.index ["product_id"], name: "index_deal_products_on_product_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string "name"
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_discount", precision: 10, scale: 2, default: "0.0"
    t.datetime "finish_date"
    t.enum "status", default: "open", null: false, enum_type: "deal_status"
    t.bigint "user_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_deals_on_customer_id"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "deal_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_taggings_on_deal_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deal_products", "deals"
  add_foreign_key "deal_products", "products"
  add_foreign_key "deals", "customers"
  add_foreign_key "deals", "users"
  add_foreign_key "taggings", "deals"
  add_foreign_key "taggings", "tags"
end
