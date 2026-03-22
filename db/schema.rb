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

ActiveRecord::Schema[7.0].define(version: 2026_03_21_160313) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flavor_gummies", force: :cascade do |t|
    t.bigint "flavor_id", null: false
    t.bigint "gummy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id", "gummy_id"], name: "index_flavor_gummies_on_flavor_id_and_gummy_id", unique: true
    t.index ["flavor_id"], name: "index_flavor_gummies_on_flavor_id"
    t.index ["gummy_id"], name: "index_flavor_gummies_on_gummy_id"
  end

  create_table "flavors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gummies", force: :cascade do |t|
    t.string "photo_url"
    t.string "name"
    t.bigint "maker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "overall_rating", default: 0, null: false
    t.integer "sweetness"
    t.integer "sourness"
    t.integer "hardness"
    t.index ["maker_id"], name: "index_gummies_on_maker_id"
  end

  create_table "makers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "gummy_id", null: false
    t.integer "rating", null: false
    t.string "purchase_location"
    t.string "photo_url"
    t.integer "sweetness"
    t.integer "sourness"
    t.integer "hardness"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gummy_id"], name: "index_reviews_on_gummy_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_image"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "flavor_gummies", "flavors"
  add_foreign_key "flavor_gummies", "gummies"
  add_foreign_key "gummies", "makers"
  add_foreign_key "reviews", "gummies"
  add_foreign_key "reviews", "users"
end
