# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.


ActiveRecord::Schema[8.0].define(version: 2026_03_15_212719) do
  create_table "distributors", force: :cascade do |t|
    t.boolean "active"
    t.text "address"
    t.string "contact_email"
    t.string "contact_name"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.string "currency"
    t.string "distributor_code"
    t.string "name"
    t.string "tax_number"
    t.datetime "updated_at", null: false
    t.index ["distributor_code"], name: "index_distributors_on_distributor_code"
  end

  create_table "order_items", force: :cascade do |t|
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.integer "order_id", null: false
    t.integer "pallets"
    t.integer "sku_id", null: false
    t.integer "units"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["sku_id"], name: "index_order_items_on_sku_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "distributor_id", null: false
    t.string "order_number"
    t.date "required_delivery_date"
    t.decimal "total_cost"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["distributor_id"], name: "index_orders_on_distributor_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "volume"
    t.text "description"
  end

  create_table "skus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "distributor_id", null: false
    t.decimal "price_per_unit"
    t.integer "product_id", null: false
    t.datetime "updated_at", null: false
    t.index ["distributor_id"], name: "index_skus_on_distributor_id"
    t.index ["product_id"], name: "index_skus_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "distributor_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["distributor_id"], name: "index_users_on_distributor_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "skus"
  add_foreign_key "orders", "distributors"
  add_foreign_key "orders", "users"
  add_foreign_key "skus", "distributors"
  add_foreign_key "skus", "products"
end
