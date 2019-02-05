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

ActiveRecord::Schema.define(version: 2019_01_25_164422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambiguous_instruments", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.bigint "datasource_line", null: false
    t.text "instrument_list", null: false
    t.bigint "resolved_id"
  end

  create_table "cached_figis", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "input_ids", null: false
    t.date "last_updated"
  end

  create_table "composite_figis", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "figi", limit: 12, null: false
    t.string "composite_figi", limit: 12, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "ticker", limit: 64
    t.string "name", limit: 128
    t.string "security_type", limit: 128
    t.string "market_sector", limit: 128
    t.string "exchange_code", limit: 32
    t.string "unique_id", limit: 32
    t.string "description"
    t.string "iso_country", limit: 2
  end

  create_table "country_maps", id: false, force: :cascade do |t|
    t.string "country", limit: 64, null: false
    t.string "iso_a2_code", limit: 2
    t.string "iso_a3_code", limit: 3
  end

  create_table "datasource_ranks", id: false, force: :cascade do |t|
    t.bigint "datasource_id", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.boolean "yesterday_backfill"
    t.integer "ranking", limit: 2
    t.boolean "composite"
    t.date "etfg_date"
  end

  create_table "datasources", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "data_source_name", limit: 50, null: false
    t.boolean "is_direct_feed", default: true, null: false
    t.string "country", limit: 2, default: "US", null: false
    t.integer "composite_rank", limit: 2, default: 5, null: false
    t.integer "constituent_rank", limit: 2, default: 5
  end

  create_table "date_adjust_fund_flows", id: false, force: :cascade do |t|
    t.string "composite_ticker", limit: 32, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.string "slug"
    t.integer "datasource_id"
  end

  create_table "etpr_templates", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "template_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holidays", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "country", limit: 2, default: "US", null: false
    t.date "market_day", null: false
    t.boolean "is_open", null: false
    t.string "description"
  end

  create_table "instrument_exceptions", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "instrument_id", null: false
    t.string "candidate_name", limit: 128, null: false
    t.string "standard_name", limit: 128, null: false
    t.string "composite_ticker", limit: 32
    t.bigint "pooled_instrument_id"
    t.string "figi", limit: 12
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.date "etfg_date"
    t.boolean "skipped", default: false, null: false
    t.string "resolution", limit: 16
    t.integer "score"
  end

  create_table "instruments", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "issuer_id"
    t.string "issuer", limit: 32
    t.string "ticker", limit: 64
    t.text "name_variants", null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.string "figi", limit: 12
    t.boolean "is_exchange_figi"
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
    t.boolean "is_valid", default: false, null: false
    t.boolean "default_instrument", default: false, null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "standard_name", limit: 128
    t.bigint "pooled_instrument_id"
    t.bigint "instrument_id"
    t.string "secid", limit: 12
    t.integer "datasource_id"
    t.text "notes"
    t.string "cusip_validated", limit: 16
    t.string "geography", limit: 3
    t.string "asset_class", limit: 128
  end

  create_table "issuer_exceptions", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.string "tablename", limit: 64, null: false
    t.string "name_in_datasource", limit: 128
  end

  create_table "issuer_variants", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "name", limit: 32, null: false
    t.integer "datasource_id", limit: 2, null: false
    t.integer "issuer_id"
    t.date "effective_date"
    t.date "expiration_date"
  end

  create_table "issuers", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "name", limit: 32, null: false
    t.date "effective_date"
    t.date "expiration_date"
  end

  create_table "known_exceptions", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.text "constituent_name", null: false
    t.string "id_type", limit: 8, null: false
    t.string "id_value", limit: 12, null: false
    t.string "country", limit: 64
    t.string "currency", limit: 16
    t.string "figi", limit: 12
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.string "composite_ticker", limit: 32
  end

  create_table "pooled_instrument_exceptions", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.date "file_date", null: false
    t.bigint "pooled_instrument_id", null: false
    t.string "name_in_datasource", limit: 128, null: false
    t.text "datasource_lines", null: false
    t.boolean "skipped", default: false, null: false
  end

  create_table "pooled_instruments", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "issuer_id"
    t.integer "instrument_id"
    t.string "issuer", limit: 64
    t.string "composite_ticker", limit: 32, null: false
    t.text "composite_name_variants", null: false
    t.string "standard_composite_name", limit: 128, null: false
    t.string "composite_description"
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
    t.string "related_index_symbol", limit: 16
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
    t.string "portfolio_manager"
    t.string "primary_benchmark"
    t.decimal "total_expenses", precision: 18, scale: 6
    t.decimal "other_expenses", precision: 18, scale: 6
    t.boolean "approved", default: false, null: false
    t.bigint "pooled_instrument_id"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.string "secid", limit: 12
    t.string "figi", limit: 12
    t.boolean "is_exchange_figi", default: false, null: false
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.integer "datasource_id"
    t.boolean "exclude_from_ts", default: false, null: false
  end

  create_table "ts_composites", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.date "etfg_date", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "pooled_instrument_id"
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.decimal "aum", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "share_value", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "open_price", precision: 22, scale: 6
    t.decimal "low_price", precision: 22, scale: 6
    t.decimal "high_price", precision: 22, scale: 6
    t.decimal "close_price", precision: 22, scale: 6
    t.decimal "daily_return", precision: 22, scale: 6
    t.decimal "avg_bid_size", precision: 22, scale: 6
    t.decimal "avg_ask_size", precision: 22, scale: 6
    t.decimal "avg_midpoint", precision: 22, scale: 6
    t.decimal "basket_estimated_cash", precision: 22, scale: 6
    t.boolean "publish", default: false, null: false
    t.date "as_of_date", null: false
    t.decimal "factor", precision: 22, scale: 6, default: "1.0"
    t.decimal "factor_shares_outstanding", precision: 22, scale: 6
  end

  create_table "ts_constituents", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.date "etfg_date", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "pooled_instrument_id"
    t.bigint "instrument_id"
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.string "constituent_ticker", limit: 64
    t.string "constituent_name", limit: 128
    t.decimal "weight", precision: 18, scale: 10
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "notional_value", precision: 22, scale: 6
    t.decimal "total_shares_held", precision: 22, scale: 6
    t.boolean "publish", default: false, null: false
    t.date "as_of_date", null: false
    t.string "currency", limit: 16
    t.decimal "coupon", precision: 22, scale: 6
    t.date "maturity_date"
    t.string "coupon_range", limit: 8
    t.integer "years_to_maturity", limit: 2
    t.string "maturity_range", limit: 8
  end

  create_table "ts_exposures", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.date "etfg_date", null: false
    t.bigint "pooled_instrument_id", null: false
    t.string "exposure_type", limit: 64, null: false
    t.string "category", limit: 64, null: false
    t.decimal "exposure_value", precision: 22, scale: 6, null: false
  end

  create_table "ts_industries", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.date "etfg_date", null: false
    t.string "composite_ticker", limit: 32
    t.string "issuer", limit: 64
    t.string "description", limit: 128
    t.date "inception_date"
    t.string "primary_benchmark"
    t.string "tax_classification", limit: 128
    t.boolean "is_etn"
    t.decimal "aum", precision: 22, scale: 6
    t.decimal "avg_daily_trading_volume", precision: 22, scale: 6
    t.string "asset_class", limit: 28
    t.string "category", limit: 28
    t.string "focus", limit: 28
    t.string "development_class", limit: 32
    t.string "region", limit: 28
    t.boolean "is_levered"
    t.decimal "levered_amount", precision: 22, scale: 6
    t.boolean "is_active"
    t.string "administrator", limit: 128
    t.string "advisor", limit: 128
    t.string "custodian", limit: 128
    t.string "distributor", limit: 128
    t.string "portfolio_manager"
    t.string "subadvisor", limit: 128
    t.string "transfer_agent", limit: 50
    t.string "trustee", limit: 128
    t.string "futures_commission_merchant", limit: 128
    t.string "fiscal_year_end", limit: 16
    t.string "distribution_frequency", limit: 32
    t.string "listing_exchange", limit: 64
    t.decimal "creation_unit_size", precision: 22, scale: 6
    t.decimal "creation_fee", precision: 22, scale: 6
    t.text "geographic_exposure"
    t.text "currency_exposure"
    t.text "sector_exposure"
    t.text "industry_group_exposure"
    t.text "industry_exposure"
    t.text "subindustry_exposure"
    t.text "coupon_exposure"
    t.text "maturity_exposure"
    t.boolean "options_available"
    t.decimal "options_volume", precision: 22, scale: 6
    t.decimal "short_interest", precision: 22, scale: 6
    t.decimal "put_call_ratio", precision: 18, scale: 6
    t.decimal "num_holdings", precision: 18, scale: 6
    t.decimal "discount_premium", precision: 18, scale: 6
    t.decimal "bid_ask_spread", precision: 18, scale: 6
    t.decimal "put_volume", precision: 18, scale: 6
    t.decimal "call_volume", precision: 18, scale: 6
    t.decimal "management_fee", precision: 18, scale: 6
    t.decimal "other_expenses", precision: 18, scale: 6
    t.decimal "total_expenses", precision: 18, scale: 6
    t.decimal "fee_waivers", precision: 18, scale: 6
    t.decimal "net_expenses", precision: 18, scale: 6
    t.string "lead_market_maker", limit: 128
    t.bigint "pooled_instrument_id", null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
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
  end

end
