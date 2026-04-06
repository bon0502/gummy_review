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

ActiveRecord::Schema[7.0].define(version: 2026_04_06_053756) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

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
    t.string "flavor"
    t.index ["maker_id"], name: "index_gummies_on_maker_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id", "review_id"], name: "index_likes_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "main_images", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_main_images_on_review_id"
  end

  create_table "makers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "rating", null: false
    t.string "purchase_location"
    t.string "photo_url"
    t.integer "sweetness"
    t.integer "sourness"
    t.integer "hardness"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "main_images"
    t.string "gummy_name"
    t.string "flavor"
    t.string "manufacturer_name"
    t.string "gummy_name_kana"
    t.string "flavor_kana"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "nickname", null: false
    t.string "profile_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "remember_token"
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "flavor_gummies", "flavors"
  add_foreign_key "flavor_gummies", "gummies"
  add_foreign_key "gummies", "makers"
  add_foreign_key "likes", "reviews"
  add_foreign_key "likes", "users"
  add_foreign_key "main_images", "reviews"
  add_foreign_key "reviews", "users"
end
