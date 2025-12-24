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

ActiveRecord::Schema[8.1].define(version: 2025_12_23_175202) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "profile_stats", force: :cascade do |t|
    t.string "avatar_url"
    t.integer "contributions_last_year", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "followers_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.datetime "last_scraped_at"
    t.string "location"
    t.string "organization"
    t.bigint "profile_id", null: false
    t.integer "stars_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_stats_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "github_url", null: false
    t.string "github_username", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["github_username"], name: "index_profiles_on_github_username", unique: true
  end

  create_table "short_urls", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.bigint "profile_id", null: false
    t.string "target_url", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_short_urls_on_code", unique: true
    t.index ["profile_id"], name: "index_short_urls_on_profile_id"
  end

  add_foreign_key "profile_stats", "profiles"
  add_foreign_key "short_urls", "profiles"
end
