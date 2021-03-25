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

ActiveRecord::Schema.define(version: 2021_03_25_184927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customization_choices", force: :cascade do |t|
    t.string "name"
    t.string "model_ref"
    t.bigint "manufacturer_id", null: false
    t.string "description"
    t.float "extra_cost"
    t.float "stock"
    t.bigint "customization_types_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customization_types_id"], name: "index_customization_choices_on_customization_types_id"
    t.index ["manufacturer_id"], name: "index_customization_choices_on_manufacturer_id"
  end

  create_table "customization_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "product_types_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_types_id"], name: "index_customization_types_on_product_types_id"
  end

  create_table "cutomization_choices", force: :cascade do |t|
    t.string "name"
    t.string "model_ref"
    t.bigint "manufacturer_id", null: false
    t.string "description"
    t.float "extra_cost"
    t.float "stock"
    t.bigint "customization_types_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customization_types_id"], name: "index_cutomization_choices_on_customization_types_id"
    t.index ["manufacturer_id"], name: "index_cutomization_choices_on_manufacturer_id"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.string "cif"
    t.string "email"
    t.string "website"
    t.string "billing_address"
    t.float "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_choice_lines", force: :cascade do |t|
    t.bigint "customization_choices_id", null: false
    t.bigint "products_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customization_choices_id"], name: "index_product_choice_lines_on_customization_choices_id"
    t.index ["products_id"], name: "index_product_choice_lines_on_products_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "hidden"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "product_types_id", null: false
    t.float "base_price"
    t.boolean "hidden"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_types_id"], name: "index_products_on_product_types_id"
  end

  add_foreign_key "customization_choices", "customization_types", column: "customization_types_id"
  add_foreign_key "customization_choices", "manufacturers"
  add_foreign_key "customization_types", "product_types", column: "product_types_id"
  add_foreign_key "cutomization_choices", "customization_types", column: "customization_types_id"
  add_foreign_key "cutomization_choices", "manufacturers"
  add_foreign_key "product_choice_lines", "customization_choices", column: "customization_choices_id"
  add_foreign_key "product_choice_lines", "products", column: "products_id"
  add_foreign_key "products", "product_types", column: "product_types_id"
end
