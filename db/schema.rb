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

ActiveRecord::Schema[7.0].define(version: 2022_09_01_132209) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "deal_status", ["lost", "open", "won"]
  create_enum "discount_type", ["none", "percent", "fixed", "free"]

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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

  create_table "deal_section_items", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "child_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_deal_section_items_on_child_id"
    t.index ["parent_id"], name: "index_deal_section_items_on_parent_id"
  end

  create_table "deal_sections", force: :cascade do |t|
    t.bigint "deal_id", null: false
    t.bigint "section_id", null: false
    t.integer "position", default: 0, null: false
    t.string "preHeading"
    t.string "heading"
    t.string "subHeading"
    t.string "buttonSubtext"
    t.json "theme"
    t.json "background"
    t.json "button"
    t.json "button2"
    t.json "links"
    t.string "headingAlignment"
    t.string "contentAlignment"
    t.string "contentLayout"
    t.string "contentStyle"
    t.string "mediaAlignment"
    t.string "mediaStyle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "child", default: false
    t.integer "parent_id"
    t.index ["deal_id"], name: "index_deal_sections_on_deal_id"
    t.index ["section_id"], name: "index_deal_sections_on_section_id"
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
    t.bigint "text_typeface_id", default: 1
    t.text "text_weight", default: "400"
    t.text "text_spacing", default: "0"
    t.text "text_height", default: "1.2"
    t.bigint "heading_typeface_id", default: 1
    t.text "heading_weight", default: "700"
    t.text "heading_spacing", default: "0"
    t.text "heading_height", default: "1.35"
    t.index ["customer_id"], name: "index_deals_on_customer_id"
    t.index ["heading_typeface_id"], name: "index_deals_on_heading_typeface_id"
    t.index ["text_typeface_id"], name: "index_deals_on_text_typeface_id"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "fonts", force: :cascade do |t|
    t.string "name"
    t.string "weights"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "section_categories", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.bigint "section_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_category_id"], name: "index_sections_on_section_category_id"
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
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "avatar_url"
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "deal_products", "deals"
  add_foreign_key "deal_products", "products"
  add_foreign_key "deal_section_items", "deal_sections", column: "child_id"
  add_foreign_key "deal_section_items", "deal_sections", column: "parent_id"
  add_foreign_key "deal_sections", "deals"
  add_foreign_key "deal_sections", "sections"
  add_foreign_key "deals", "customers"
  add_foreign_key "deals", "fonts", column: "heading_typeface_id"
  add_foreign_key "deals", "fonts", column: "text_typeface_id"
  add_foreign_key "deals", "users"
  add_foreign_key "sections", "section_categories"
  add_foreign_key "taggings", "deals"
  add_foreign_key "taggings", "tags"
end
