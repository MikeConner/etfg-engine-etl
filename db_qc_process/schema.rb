# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_04_030915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "composite_merge_templates", force: :cascade do |t|
    t.bigint "user_id"
    t.string "template_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_composite_merge_templates_on_user_id"
  end

  create_table "dag_statuses", force: :cascade do |t|
    t.string "datasource", limit: 32, null: false
    t.date "etfg_date", null: false
    t.string "process", limit: 64, null: false
    t.string "status", limit: 128, null: false
    t.boolean "completed", default: false, null: false
    t.date "updated_at"
  end

  create_table "etpr_templates", force: :cascade do |t|
    t.bigint "user_id"
    t.string "template_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_etpr_templates_on_user_id"
  end

  create_table "instrument_templates", force: :cascade do |t|
    t.bigint "user_id"
    t.string "template_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_instrument_templates_on_user_id"
  end

  create_table "row_counts", id: false, comment: "Keep historical row counts in order to detect anomalies", force: :cascade do |t|
    t.string "filename", limit: 50, null: false
    t.date "download_date", null: false
    t.bigint "row_count", null: false
    t.bigint "bad_rows", default: 0, null: false
    t.index ["filename", "download_date"], name: "file_and_date", unique: true
  end

  create_table "settings", primary_key: "key", id: :string, force: :cascade do |t|
    t.string "value", null: false
  end

end
