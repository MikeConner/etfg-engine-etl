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

ActiveRecord::Schema.define(version: 2018_08_21_084907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "barclays_calendar_letns_eod", force: :cascade do |t|
    t.string "cusip"
    t.string "isin"
    t.string "ticker"
    t.date "date"
    t.string "name"
    t.decimal "indicative_value"
    t.integer "shares_outstanding"
    t.decimal "index_value"
    t.decimal "coupon"
    t.decimal "market_capitalization"
    t.decimal "closing_participation"
    t.decimal "closing_note_financing_level"
    t.decimal "closing_note_t_bills_amount"
    t.decimal "closing_note_index_exposure"
    t.decimal "next_closing_note_financing_level"
    t.decimal "next_closing_note_t_bills_amount"
    t.decimal "equity_allocation"
    t.decimal "vol_allocation"
    t.decimal "short_vxx_shares"
    t.decimal "vxx_closing_nav"
    t.decimal "accrued_fees"
    t.decimal "accrued_interest"
    t.date "etfg_date"
  end

  create_table "barclays_etns_eod", force: :cascade do |t|
    t.string "cusip"
    t.string "isin"
    t.string "ticker"
    t.date "date"
    t.string "name"
    t.decimal "indicative_value"
    t.integer "shares_outstanding"
    t.decimal "index_value"
    t.decimal "coupon"
    t.decimal "market_capitalization"
    t.date "etfg_date"
  end

  create_table "bmo_basket_composites", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.string "account_number", limit: 32
    t.string "composite_name", limit: 128
    t.decimal "units_outstanding", precision: 18, scale: 6
    t.decimal "nav", precision: 18, scale: 6
    t.decimal "projected_cash", precision: 18, scale: 6
    t.decimal "dist_price_adj", precision: 18, scale: 6
    t.decimal "fx_rate", precision: 18, scale: 6
    t.decimal "mer_expense_ratio", precision: 18, scale: 6
    t.decimal "prescribed_units", precision: 18, scale: 6
    t.decimal "caf_pct", precision: 18, scale: 6
  end

  create_table "bmo_basket_constituents", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.string "ticker", limit: 64
    t.string "constituent_ticker", limit: 64
    t.string "constituent_name", limit: 128
    t.string "constituent_country", limit: 32
    t.decimal "price", precision: 18, scale: 6
    t.decimal "shares_per_basket", precision: 18, scale: 6
    t.decimal "number_shares", precision: 18, scale: 6
    t.string "sedol", limit: 7
  end

  create_table "bmo_holdings", id: false, force: :cascade do |t|
    t.date "etfg_date", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.string "constituent_ticker", limit: 64, null: false
    t.string "constituent_name", limit: 128
    t.string "constituent_country", limit: 64
    t.string "instrument_type", limit: 128
    t.string "security_id", limit: 64
    t.decimal "total_shares_held", precision: 18, scale: 6
    t.string "sedol", limit: 7
    t.string "cusip", limit: 9
  end

  create_table "df_composite_identifiers", id: false, force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.string "ticker", limit: 32, null: false
    t.string "name", limit: 128
    t.string "figi", limit: 12, null: false
    t.boolean "composite_figi", default: true, null: false
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.string "secid", limit: 12
    t.index ["datasource_id", "ticker"], name: "index_df_composite_identifiers_on_datasource_id_and_ticker", unique: true
    t.index ["figi"], name: "index_df_composite_identifiers_on_figi", unique: true
    t.index ["ticker"], name: "index_df_composite_identifiers_on_ticker"
  end

  create_table "staging_composites", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "pooled_instrument_id"
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.string "composite_description", limit: 128
    t.decimal "aum", precision: 18, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 6
    t.decimal "share_value", precision: 18, scale: 6
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
    t.integer "issuer_id"
    t.string "issuer", limit: 32
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
    t.string "industry_group", limit: 128
    t.string "subindustry", limit: 128
    t.string "rating", limit: 32
    t.boolean "is_index"
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
    t.decimal "total_expenses", precision: 18, scale: 6
    t.decimal "other_expenses", precision: 18, scale: 6
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
    t.boolean "match", default: false, null: false
    t.index ["as_of_date", "datasource_id"], name: "index_staging_composites_on_as_of_date_and_datasource_id"
    t.index ["composite_ticker", "exchange_country"], name: "ticker_country_composites"
    t.index ["composite_ticker"], name: "index_staging_composites_on_composite_ticker"
    t.index ["etfg_date", "datasource_id"], name: "index_staging_composites_on_etfg_date_and_datasource_id"
    t.index ["figi"], name: "index_staging_composites_on_figi"
  end

  create_table "staging_constituents", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.integer "datasource_id", null: false
    t.bigint "pooled_instrument_id"
    t.bigint "instrument_id"
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.string "constituent_ticker", limit: 64
    t.string "constituent_name", limit: 128
    t.decimal "weight", precision: 18, scale: 6
    t.decimal "market_value", precision: 18, scale: 6
    t.decimal "notional_value", precision: 18, scale: 6
    t.decimal "total_shares_held", precision: 18, scale: 6
    t.integer "issuer_id"
    t.string "issuer", limit: 32
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
    t.string "industry_group", limit: 128
    t.string "subindustry", limit: 128
    t.string "rating", limit: 32
    t.boolean "match", default: false, null: false
    t.index ["as_of_date", "datasource_id"], name: "index_staging_constituents_on_as_of_date_and_datasource_id"
    t.index ["composite_ticker", "exchange_country"], name: "ticker_country_constituents"
    t.index ["composite_ticker"], name: "index_staging_constituents_on_composite_ticker"
    t.index ["etfg_date", "datasource_id"], name: "index_staging_constituents_on_etfg_date_and_datasource_id"
    t.index ["figi"], name: "index_staging_constituents_on_figi"
  end

end
