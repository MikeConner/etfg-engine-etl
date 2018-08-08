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

ActiveRecord::Schema.define(version: 2018_08_08_213902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambiguous_instruments", force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.bigint "datasource_line", null: false
    t.text "instrument_list", null: false
    t.bigint "resolved_id"
    t.index ["datasource_id", "file_date", "datasource_line"], name: "no_ambig_dups", unique: true
    t.index ["datasource_id", "file_date", "datasource_line"], name: "no_dups_ambigs", unique: true
    t.index ["datasource_id", "file_date"], name: "ambiguous_date"
    t.index ["datasource_id", "file_date"], name: "speed_up_ambigs"
  end

  create_table "composite_figis", id: :bigint, default: -> { "nextval('figi_map_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "figi", limit: 12, null: false
    t.string "composite_figi", limit: 12, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "ticker", limit: 64
    t.string "name", limit: 128
    t.string "security_type", limit: 128
    t.string "market_sector", limit: 128
    t.string "exchange_code", limit: 32
    t.string "unique_id", limit: 32
    t.string "description"
    t.string "iso_country", limit: 2
    t.index ["composite_figi"], name: "composite", opclass: :bpchar_pattern_ops
    t.index ["composite_figi"], name: "index_composite_figis_on_composite_figi"
    t.index ["figi", "composite_figi"], name: "no_figi_map_dups", unique: true
    t.index ["figi"], name: "index_composite_figis_on_figi"
    t.index ["figi"], name: "speed_up", opclass: :bpchar_pattern_ops
  end

  create_table "datasources", id: :bigint, default: -> { "nextval('etfg_datasources_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "data_source_name", limit: 50, null: false
    t.boolean "is_direct_feed", default: true, null: false
  end

  create_table "instrument_exceptions", force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.bigint "instrument_id", null: false
    t.string "name_in_datasource", limit: 128, null: false
    t.text "datasource_lines", null: false
    t.index ["datasource_id", "file_date"], name: "exceptions_file_date"
    t.index ["datasource_id", "file_date"], name: "idx_data_on_date"
    t.index ["datasource_id"], name: "fki_fk_datasource"
    t.index ["datasource_id"], name: "index_instrument_exceptions_on_datasource_id"
    t.index ["instrument_id"], name: "fki_fk_instrument_exceptions"
    t.index ["instrument_id"], name: "index_instrument_exceptions_on_instrument_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.integer "issuer_id"
    t.string "issuer", limit: 32
    t.string "ticker", limit: 64
    t.text "name_variants", null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.string "figi", limit: 12, null: false
    t.boolean "is_exchange_figi", null: false
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.string "exchange_country", limit: 64
    t.string "currency", limit: 16
    t.string "exchange", limit: 64
    t.string "market_sector", limit: 128
    t.string "security_type", limit: 128
    t.string "sector", limit: 64
    t.string "industry", limit: 64
    t.string "master_guid", limit: 36
    t.string "industry_group", limit: 128
    t.string "subindustry", limit: 128
    t.string "rating", limit: 32
    t.boolean "approved", default: false, null: false
    t.boolean "is_valid", null: false
    t.boolean "default_instrument", default: false, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "standard_name", limit: 128
    t.bigint "pooled_instrument_id"
    t.bigint "instrument_id"
    t.index ["cusip"], name: "instrument_cusip", opclass: :bpchar_pattern_ops
    t.index ["figi"], name: "speed_up_figi", unique: true, opclass: :bpchar_pattern_ops
    t.index ["isin"], name: "instrument_isin", opclass: :bpchar_pattern_ops
    t.index ["issuer_id"], name: "fki_fk_issuer"
    t.index ["pooled_instrument_id"], name: "fki_fk_pooled_instrument"
    t.index ["sedol"], name: "instrument_sedol", opclass: :bpchar_pattern_ops
  end

  create_table "issuer_exceptions", force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.string "tablename", limit: 64, null: false
    t.string "name_in_datasource", limit: 128
    t.index ["datasource_id", "file_date"], name: "exceptions_file_date_issuer"
    t.index ["datasource_id", "file_date"], name: "index_issuer_exceptions_on_datasource_id_and_file_date"
    t.index ["datasource_id", "name_in_datasource"], name: "index_issuer_exceptions_on_datasource_id_and_name_in_datasource", unique: true
    t.index ["datasource_id", "name_in_datasource"], name: "no_dup_excs", unique: true
    t.index ["datasource_id"], name: "fki_fk_exception_datasource"
    t.index ["datasource_id"], name: "index_issuer_exceptions_on_datasource_id"
  end

  create_table "issuer_variants", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.integer "datasource_id", limit: 2, null: false
    t.integer "issuer_id"
    t.index ["datasource_id"], name: "fki_src_key"
    t.index ["datasource_id"], name: "index_issuer_variants_on_datasource_id"
    t.index ["name", "issuer_id"], name: "index_issuer_variants_on_name_and_issuer_id", unique: true
    t.index ["name", "issuer_id"], name: "uniq_names", unique: true
    t.index ["name"], name: "index_issuer_variants_on_name"
    t.index ["name"], name: "issuer_name", opclass: :varchar_pattern_ops
  end

  create_table "issuers", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.index ["name"], name: "index_issuers_on_name", unique: true
    t.index ["name"], name: "name_idx", opclass: :varchar_pattern_ops
    t.index ["name"], name: "no_dups_names", unique: true
  end

  create_table "known_exceptions", force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.text "constituent_name", null: false
    t.string "id_type", limit: 8, null: false
    t.string "id_value", limit: 12, null: false
    t.string "figi", limit: 12
    t.index ["datasource_id"], name: "fki_fk_known_ex_ds"
    t.index ["datasource_id"], name: "index_known_exceptions_on_datasource_id"
  end

  create_table "pooled_instrument_exceptions", force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.bigint "pooled_instrument_id", null: false
    t.string "name_in_datasource", limit: 128, null: false
    t.text "datasource_lines", null: false
    t.index ["datasource_id", "file_date", "pooled_instrument_id", "name_in_datasource"], name: "detect_dups", unique: true
    t.index ["datasource_id", "file_date", "pooled_instrument_id", "name_in_datasource"], name: "no_dups_piexc", unique: true
    t.index ["datasource_id"], name: "fki_fk_comp_datasource"
    t.index ["pooled_instrument_id"], name: "fki_fk_composite_ex_pooled"
  end

  create_table "pooled_instrument_overwrites", force: :cascade do |t|
    t.bigint "instrument_id", null: false
    t.bigint "previous_composite_id", null: false
    t.bigint "current_composite_id", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.bigint "datasource_line", null: false
  end

  create_table "pooled_instruments", force: :cascade do |t|
    t.integer "issuer_id"
    t.integer "instrument_id"
    t.string "issuer", limit: 32, null: false
    t.string "composite_ticker", limit: 32, null: false
    t.text "composite_name_variants", null: false
    t.string "standard_composite_name", limit: 128, null: false
    t.string "composite_description", limit: 128
    t.date "effective_date"
    t.date "expiration_date"
    t.string "exchange_country", limit: 64, null: false
    t.boolean "is_index", default: false, null: false
    t.boolean "is_active"
    t.boolean "is_etn"
    t.boolean "is_levered"
    t.boolean "is_inverse"
    t.boolean "has_derivatives"
    t.boolean "options_available"
    t.date "inception_date"
    t.string "etp_structure_type", limit: 50
    t.string "category", limit: 28
    t.string "related_index", limit: 50
    t.string "related_index_symbol", limit: 16
    t.string "related_index_name", limit: 50
    t.decimal "net_expenses", precision: 18, scale: 6
    t.decimal "expense_ratio", precision: 18, scale: 6
    t.string "listing_exchange", limit: 64
    t.string "asset_class", limit: 28
    t.string "development_class", limit: 32
    t.string "focus", limit: 28
    t.string "lead_market_maker", limit: 128
    t.string "region", limit: 28
    t.decimal "levered_amount", precision: 18, scale: 6
    t.date "maturity_date"
    t.string "exposure_country", limit: 64
    t.string "selection_criteria", limit: 32
    t.string "weighting_scheme", limit: 32
    t.string "administrator", limit: 128
    t.string "advisor", limit: 128
    t.string "distributor", limit: 128
    t.decimal "fee_waivers", precision: 18, scale: 6
    t.string "fiscal_year_end", limit: 16
    t.string "futures_commission_merchant", limit: 128
    t.string "subadvisor", limit: 128
    t.string "tax_classification", limit: 128
    t.string "transfer_agent", limit: 50
    t.string "trustee", limit: 128
    t.decimal "creation_fee", precision: 18, scale: 6
    t.decimal "creation_unit_size", precision: 18, scale: 6
    t.string "custodian", limit: 128
    t.string "distribution_frequency", limit: 32
    t.decimal "management_fee", precision: 18, scale: 6
    t.string "portfolio_manager", limit: 128
    t.string "primary_benchmark"
    t.decimal "total_expenses", precision: 18, scale: 6
    t.decimal "other_expenses", precision: 18, scale: 6
    t.boolean "approved", default: false, null: false
    t.bigint "pooled_instrument_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["composite_ticker"], name: "index_pooled_instruments_on_composite_ticker"
    t.index ["composite_ticker"], name: "ticker", opclass: :varchar_ops
    t.index ["instrument_id"], name: "fki_fk_comp_instr"
    t.index ["instrument_id"], name: "index_pooled_instruments_on_instrument_id"
    t.index ["issuer_id"], name: "fki_fk_comp_issuer"
    t.index ["issuer_id"], name: "index_pooled_instruments_on_issuer_id"
  end

  create_table "ts_composites", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "pooled_instrument_id", null: false
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128, null: false
    t.decimal "aum", precision: 18, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 6
    t.decimal "share_volue", precision: 18, scale: 6
    t.decimal "nav", precision: 18, scale: 6
    t.decimal "open_price", precision: 18, scale: 6
    t.decimal "low_price", precision: 18, scale: 6
    t.decimal "high_price", precision: 18, scale: 6
    t.decimal "close_price", precision: 18, scale: 6
    t.decimal "daily_return", precision: 18, scale: 6
    t.decimal "bid_ask_spread", precision: 18, scale: 6
    t.decimal "avg_bid_size", precision: 18, scale: 6
    t.decimal "avg_ask_size", precision: 18, scale: 6
    t.decimal "avg_midpoint", precision: 18, scale: 6
    t.decimal "basket_estimated_cash", precision: 18, scale: 6
    t.boolean "publish", default: false, null: false
    t.index ["datasource_id"], name: "index_ts_composites_on_datasource_id"
    t.index ["etfg_date", "datasource_id"], name: "index_ts_composites_on_etfg_date_and_datasource_id"
    t.index ["etfg_date"], name: "index_ts_composites_on_etfg_date"
    t.index ["pooled_instrument_id"], name: "index_ts_composites_on_pooled_instrument_id"
  end

  create_table "ts_constituents", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "pooled_instrument_id", null: false
    t.bigint "instrument_id", null: false
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128, null: false
    t.string "constituent_ticker", limit: 64
    t.string "constituent_name", limit: 128, null: false
    t.decimal "weight", precision: 18, scale: 6
    t.decimal "market_value", precision: 18, scale: 6
    t.decimal "notional_value", precision: 18, scale: 6
    t.decimal "total_shares_held", precision: 18, scale: 6
    t.boolean "publish", default: false, null: false
    t.index ["datasource_id"], name: "index_ts_constituents_on_datasource_id"
    t.index ["etfg_date", "datasource_id"], name: "index_ts_constituents_on_etfg_date_and_datasource_id"
    t.index ["etfg_date"], name: "index_ts_constituents_on_etfg_date"
    t.index ["instrument_id"], name: "index_ts_constituents_on_instrument_id"
    t.index ["pooled_instrument_id"], name: "index_ts_constituents_on_pooled_instrument_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "instrument_exceptions", "datasources", name: "fk_datasource"
  add_foreign_key "instruments", "issuers", name: "fk_issuer"
  add_foreign_key "issuer_exceptions", "datasources", name: "fk_exception_datasource"
  add_foreign_key "issuer_variants", "datasources", name: "src_key"
  add_foreign_key "issuer_variants", "issuers", name: "fk_issuer"
  add_foreign_key "known_exceptions", "datasources", name: "fk_known_ex_ds"
  add_foreign_key "pooled_instrument_exceptions", "datasources", name: "fk_comp_datasource"
  add_foreign_key "pooled_instrument_exceptions", "pooled_instruments", name: "fk_composite_ex_pooled"
  add_foreign_key "pooled_instrument_exceptions", "pooled_instruments", name: "fk_composite_exceptions"
  add_foreign_key "pooled_instrument_overwrites", "datasources", name: "piex_datasrc"
  add_foreign_key "pooled_instruments", "issuers", name: "fk_comp_issuer"
  add_foreign_key "ts_composites", "datasources"
  add_foreign_key "ts_composites", "pooled_instruments"
  add_foreign_key "ts_constituents", "datasources"
  add_foreign_key "ts_constituents", "instruments"
  add_foreign_key "ts_constituents", "pooled_instruments"
end
