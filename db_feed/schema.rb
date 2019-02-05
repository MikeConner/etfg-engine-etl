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

ActiveRecord::Schema.define(version: 2019_01_31_204704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agf_lookups", id: false, force: :cascade do |t|
    t.string "ticker", limit: 32, null: false
    t.string "holdings_name", limit: 128, null: false
    t.string "nav_name", limit: 128, null: false
  end

  create_table "alps_hold", force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "fund_id", limit: 4
    t.string "ticker", limit: 64
    t.string "cusip", limit: 9
    t.string "sedol", limit: 7
    t.string "display_name", limit: 128
    t.decimal "shares", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "cost", precision: 22, scale: 6
    t.decimal "fx_rate", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "px_factor", precision: 22, scale: 6
    t.string "px_source", limit: 8
    t.string "px_type", limit: 32
    t.string "px_memo", limit: 255
    t.decimal "cur_mkt_cap", precision: 22, scale: 6
    t.string "bb_tkr", limit: 32
    t.string "primary_id", limit: 64
    t.string "fund", limit: 128
    t.string "asset_type_1", limit: 64
    t.string "category_code1", limit: 32
    t.string "currency", limit: 3
    t.string "country", limit: 64
    t.string "state", limit: 32
    t.string "industry", limit: 64
    t.string "issuer_name", limit: 128
    t.string "legal_name", limit: 64
    t.decimal "shares_out", precision: 22, scale: 6
    t.string "nips", limit: 32
    t.string "is_short", limit: 4
    t.string "is_144a", limit: 4
    t.string "sector", limit: 128
    t.string "secid", limit: 12
    t.string "occ_code", limit: 32
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "alps_hold_template", id: false, force: :cascade do |t|
    t.text "as_of_date"
    t.text "fund_id"
    t.text "ticker"
    t.text "cusip"
    t.text "sedol"
    t.text "display_name"
    t.text "shares"
    t.text "market_value"
    t.text "cost"
    t.text "fx_rate"
    t.text "price"
    t.text "px_factor"
    t.text "px_source"
    t.text "px_type"
    t.text "px_memo"
    t.text "cur_mkt_cap"
    t.text "bb_tkr"
    t.text "primary_id"
    t.text "fund"
    t.text "asset_type_1"
    t.text "category_code1"
    t.text "currency"
    t.text "country"
    t.text "state"
    t.text "industry"
    t.text "issuer_name"
    t.text "legal_name"
    t.text "shares_out"
    t.text "nips"
    t.text "is_short"
    t.text "is_144a"
    t.text "sector"
    t.text "secid"
    t.text "occ_code"
  end

  create_table "alps_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "unique_identifier", limit: 32
    t.string "fund_name", limit: 128
    t.string "cusip", limit: 9
    t.string "ticker", limit: 32
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "daily_dividend_factor", precision: 22, scale: 6
    t.decimal "total_net_assets", precision: 22, scale: 6
    t.decimal "sec_yield", precision: 22, scale: 6
    t.decimal "_7_day_yield", precision: 22, scale: 6
    t.date "ex_date"
    t.date "reinvest_date"
    t.decimal "non_qualified_div", precision: 22, scale: 6
    t.decimal "qualified_div", precision: 22, scale: 6
    t.decimal "interest_income", precision: 22, scale: 6
    t.decimal "tax_free_div", precision: 22, scale: 6
    t.decimal "short_term_cg", precision: 22, scale: 6
    t.decimal "long_term_cg", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "daily_dividend_days", precision: 22, scale: 6
    t.date "daily_pay_date"
  end

  create_table "alps_nav_template", id: false, force: :cascade do |t|
    t.text "unique_identifier"
    t.text "fund_name"
    t.text "cusip"
    t.text "ticker"
    t.text "nav_date"
    t.text "nav"
    t.text "daily_dividend_factor"
    t.text "total_net_assets"
    t.text "sec_yield"
    t.text "_7_day_yield"
    t.text "ex_date"
    t.text "reinvest_date"
    t.text "non_qualified_div"
    t.text "qualified_div"
    t.text "interest_income"
    t.text "tax_free_div"
    t.text "short_term_cg"
    t.text "long_term_cg"
    t.text "shares_outstanding"
    t.text "daily_dividend_days"
    t.text "daily_pay_date"
  end

  create_table "asset_class_lookups", force: :cascade do |t|
    t.string "security_type"
    t.string "asset_class", limit: 128
  end

  create_table "bbh_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.decimal "_30_day_effective_yield", precision: 22, scale: 10
    t.decimal "_30_day_yield", precision: 22, scale: 10
    t.decimal "_7_day_effective_yield", precision: 22, scale: 10
    t.decimal "_7_day_yield", precision: 22, scale: 10
    t.text "accounting_basis"
    t.text "accounting_date"
    t.text "average_days_to_maturity"
    t.text "average_years_to_maturity"
    t.text "base_currency_code"
    t.decimal "cap_factor_long", precision: 22, scale: 10
    t.decimal "cap_factor_short", precision: 22, scale: 10
    t.text "change_in_distribution_rate"
    t.text "class_identifier"
    t.decimal "closing_market_price", precision: 22, scale: 10
    t.text "cusip"
    t.text "custody_head_account_number"
    t.decimal "daily_distribution", precision: 22, scale: 10
    t.decimal "daily_distribution_rate", precision: 22, scale: 10
    t.decimal "daily_yield", precision: 22, scale: 10
    t.text "entity_name"
    t.text "entity_number"
    t.text "ex_date"
    t.text "exchange"
    t.decimal "fx_rate", precision: 22, scale: 10
    t.decimal "fixed_distribution_amount", precision: 22, scale: 10
    t.text "isin"
    t.text "local_currency"
    t.decimal "long_term_cap_gain_distribution", precision: 22, scale: 10
    t.decimal "nav", precision: 22, scale: 10
    t.decimal "nav_change", precision: 22, scale: 10
    t.decimal "nav_expanded_base_equivalent", precision: 22, scale: 10
    t.decimal "nav_percent_change", precision: 22, scale: 10
    t.decimal "offering_change", precision: 22, scale: 10
    t.decimal "offering_price", precision: 22, scale: 10
    t.text "pay_date"
    t.decimal "periodic_distribution_amount", precision: 22, scale: 10
    t.decimal "periodic_distribution_rate", precision: 22, scale: 10
    t.decimal "periodic_income_distribution", precision: 22, scale: 10
    t.decimal "premium_discount", precision: 22, scale: 10
    t.decimal "previous_market_price", precision: 22, scale: 10
    t.decimal "prior_nav", precision: 22, scale: 10
    t.decimal "previous_offering_price", precision: 22, scale: 10
    t.text "record_date"
    t.decimal "redemption_amount", precision: 22, scale: 10
    t.decimal "redemption_exchange_amount", precision: 22, scale: 10
    t.decimal "redemption_exchange_shares", precision: 22, scale: 10
    t.decimal "redemption_shares", precision: 22, scale: 10
    t.decimal "reinvestment_amount", precision: 22, scale: 10
    t.text "reinvestment_date"
    t.decimal "reinvestment_price", precision: 22, scale: 10
    t.decimal "reinvestment_shares", precision: 22, scale: 10
    t.decimal "sec_yield", precision: 22, scale: 10
    t.decimal "securities_at_market_value", precision: 22, scale: 10
    t.decimal "settled_shares", precision: 22, scale: 10
    t.decimal "shares_outstanding", precision: 22, scale: 10
    t.decimal "short_term_cap_gain_distribution", precision: 22, scale: 10
    t.decimal "stock_dividend_rate", precision: 22, scale: 10
    t.decimal "subscription_amount", precision: 22, scale: 10
    t.decimal "subscription_exchange_amount", precision: 22, scale: 10
    t.decimal "subscription_exchange_shares", precision: 22, scale: 10
    t.decimal "subscription_shares", precision: 22, scale: 10
    t.text "ticker_symbol"
    t.decimal "total_net_assets", precision: 22, scale: 10
    t.decimal "net_cap_stock_activity", precision: 22, scale: 10
    t.decimal "relative_net_asset", precision: 22, scale: 10
    t.text "akgestg"
    t.text "ip"
    t.text "vg"
    t.text "tis"
    t.text "tid"
    t.text "tid_pct"
    t.text "prior_accounting_date"
    t.text "inception_date_shr_cls"
    t.text "inception_date_fund"
    t.decimal "sub_nav", precision: 22, scale: 10
    t.decimal "red_nav", precision: 22, scale: 10
    t.decimal "local_nav_cls_level", precision: 22, scale: 10
    t.decimal "local_tna_cls_level", precision: 22, scale: 10
    t.decimal "base_nav_cls_level", precision: 22, scale: 10
    t.decimal "base_tna_cls_level", precision: 22, scale: 10
    t.decimal "local_shrs_out_cls_level", precision: 22, scale: 10
    t.decimal "base_shrs_out_cls_level", precision: 22, scale: 10
    t.decimal "base_tna_fund_level", precision: 22, scale: 10
    t.decimal "shrs_out_fund_level", precision: 22, scale: 10
    t.text "wkn_indicator"
    t.text "sedol"
    t.text "bloomberg_id"
    t.text "lipper_id"
    t.text "reuters_id"
    t.text "btis_report_amount"
    t.text "client_fund_id"
    t.text "share_class_name"
    t.text "futval"
    t.string "source_name", limit: 16
    t.index ["etfg_date"], name: "bbh_nav_etfg_date"
  end

  create_table "bbh_nav_template", id: false, force: :cascade do |t|
    t.text "_30_day_effective_yield"
    t.text "_30_day_yield"
    t.text "_7_day_effective_yield"
    t.text "_7_day_yield"
    t.text "accounting_basis"
    t.text "accounting_date"
    t.text "average_days_to_maturity"
    t.text "average_years_to_maturity"
    t.text "base_currency_code"
    t.text "cap_factor_long"
    t.text "cap_factor_short"
    t.text "change_in_distribution_rate"
    t.text "class_identifier"
    t.text "closing_market_price"
    t.text "cusip"
    t.text "custody_head_account_number"
    t.text "daily_distribution"
    t.text "daily_distribution_rate"
    t.text "daily_yield"
    t.text "entity_name"
    t.text "entity_number"
    t.text "ex_date"
    t.text "exchange"
    t.text "fx_rate"
    t.text "fixed_distribution_amount"
    t.text "isin"
    t.text "local_currency"
    t.text "long_term_cap_gain_distribution"
    t.text "nav"
    t.text "nav_change"
    t.text "nav_expanded_base_equivalent"
    t.text "nav_percent_change"
    t.text "offering_change"
    t.text "offering_price"
    t.text "pay_date"
    t.text "periodic_distribution_amount"
    t.text "periodic_distribution_rate"
    t.text "periodic_income_distribution"
    t.text "premium_discount"
    t.text "previous_market_price"
    t.text "prior_nav"
    t.text "previous_offering_price"
    t.text "record_date"
    t.text "redemption_amount"
    t.text "redemption_exchange_amount"
    t.text "redemption_exchange_shares"
    t.text "redemption_shares"
    t.text "reinvestment_amount"
    t.text "reinvestment_date"
    t.text "reinvestment_price"
    t.text "reinvestment_shares"
    t.text "sec_yield"
    t.text "securities_at_market_value"
    t.text "settled_shares"
    t.text "shares_outstanding"
    t.text "short_term_cap_gain_distribution"
    t.text "stock_dividend_rate"
    t.text "subscription_amount"
    t.text "subscription_exchange_amount"
    t.text "subscription_exchange_shares"
    t.text "subscription_shares"
    t.text "ticker_symbol"
    t.text "total_net_assets"
    t.text "net_cap_stock_activity"
    t.text "relative_net_asset"
    t.text "akgestg"
    t.text "ip"
    t.text "vg"
    t.text "tis"
    t.text "tid"
    t.text "tid_pct"
    t.text "prior_accounting_date"
    t.text "inception_date_shr_cls"
    t.text "inception_date_fund"
    t.text "sub_nav"
    t.text "red_nav"
    t.text "local_nav_cls_level"
    t.text "local_tna_cls_level"
    t.text "base_nav_cls_level"
    t.text "base_tna_cls_level"
    t.text "local_shrs_out_cls_level"
    t.text "base_shrs_out_cls_level"
    t.text "base_tna_fund_level"
    t.text "shrs_out_fund_level"
    t.text "wkn_indicator"
    t.text "sedol"
    t.text "bloomberg_id"
    t.text "lipper_id"
    t.text "reuters_id"
    t.text "btis_report_amount"
    t.text "client_fund_id"
    t.text "share_class_name"
    t.text "futval"
  end

  create_table "bbh_pval", force: :cascade do |t|
    t.date "etfg_date"
    t.text "accounting_basis"
    t.text "accounting_date"
    t.text "asset_currency"
    t.text "average_days_to_maturity"
    t.text "average_years_to_maturity"
    t.text "bbh_security_id"
    t.text "base_amortized_cost"
    t.text "base_currency_code"
    t.text "base_interest_receivable"
    t.decimal "base_market_value", precision: 22, scale: 6
    t.text "base_market_value_change"
    t.text "base_notional_amount"
    t.text "base_original_cost"
    t.text "base_price"
    t.text "base_price_change"
    t.text "base_total_unrealized_gain"
    t.text "base_total_unrealized_loss"
    t.text "base_unit_cost"
    t.text "base_unrealized_currency_gain"
    t.text "base_unrealized_currency_loss"
    t.text "base_unrealized_security_gain"
    t.text "base_unrealized_security_loss"
    t.text "bloomberg_industry_group"
    t.text "bloomberg_industry_sector"
    t.text "bloomberg_industry_subgroup_code"
    t.text "bloomberg_industry_subgroup_description"
    t.text "cpi_index_ratio"
    t.text "cusip"
    t.text "close_event_id"
    t.text "cost_method"
    t.text "country_code"
    t.text "country_description"
    t.text "currency_description"
    t.text "current_face"
    t.text "custody_head_account_number"
    t.text "days_to_maturity"
    t.text "entity_name"
    t.text "entity_number"
    t.text "fx_rate"
    t.text "isin"
    t.text "industry_type_code"
    t.text "interest_rate"
    t.text "investment_type_code"
    t.text "investment_type_description"
    t.text "issue_date"
    t.text "issue_price"
    t.text "local_amortized_cost"
    t.text "local_currency_code"
    t.text "local_market_value"
    t.text "local_market_value_change"
    t.text "local_notional_amount"
    t.text "local_original_cost"
    t.text "local_price"
    t.text "local_price_change"
    t.text "local_price_change_percent"
    t.text "local_unit_cost"
    t.text "local_unrealized_security_gain"
    t.text "local_unrealized_security_loss"
    t.text "long_short_indicator"
    t.text "maturity_date"
    t.text "maturity_tier_code"
    t.text "maturity_tier_description"
    t.text "monthly_daily_indicator"
    t.text "moodys_rating"
    t.text "moodys_rating_date"
    t.decimal "nav", precision: 22, scale: 10
    t.text "net_assets_excluding_securities"
    t.text "open_event_id"
    t.text "original_face"
    t.text "per_share_nav_impact"
    t.text "percent_change_in_market_value"
    t.text "percent_mv"
    t.text "percent_tna"
    t.text "previous_accounting_date"
    t.text "previous_base_amortized_cost"
    t.text "previous_base_market_value"
    t.text "previous_base_price"
    t.text "previous_base_unit_cost"
    t.text "previous_base_unrealized_gl"
    t.text "previous_capital_gl"
    t.text "previous_currency_gl"
    t.text "previous_fx_rate"
    t.text "previous_local_amortized_cost"
    t.text "previous_local_market_value"
    t.text "previous_local_price"
    t.text "previous_local_unit_cost"
    t.text "previous_local_unrealized_gl"
    t.text "previous_nav"
    t.text "previous_outstanding_settled_shares"
    t.text "previous_price_date"
    t.text "previous_quantity"
    t.text "previous_shares_outstanding"
    t.text "previous_total_base_market_value"
    t.text "price_effective_date"
    t.text "price_factor"
    t.text "primary_traded_exchange_by_security_by_fund"
    t.text "private_placement_indicator"
    t.text "processing_security_type"
    t.decimal "quantity", precision: 22, scale: 10
    t.text "quantity_change"
    t.text "quantity_scale"
    t.text "report_type"
    t.text "sedol"
    t.text "sic_code"
    t.text "securities_at_market_value"
    t.text "restricted_flag"
    t.text "security_alias_id"
    t.text "security_description"
    t.text "security_id"
    t.text "security_id_type"
    t.text "security_long_description"
    t.text "security_type_code"
    t.text "security_type_description"
    t.text "settlement_date"
    t.decimal "shares_outstanding", precision: 22, scale: 10
    t.text "source_c"
    t.text "state_code"
    t.text "sub_security_type_code"
    t.text "sub_security_type_description"
    t.text "ticker_symbol"
    t.text "total_base_market_value"
    t.text "total_current_assets"
    t.text "total_current_liabilities"
    t.text "total_dividend_marked_to_market"
    t.text "total_forward_currency_marked_to_market"
    t.text "total_interest_marked_to_market"
    t.decimal "total_net_assets", precision: 22, scale: 10
    t.text "total_outstanding_settled_shares"
    t.text "trade_date"
    t.text "trade_date_fx_rate"
    t.text "underlying_security_description"
    t.text "underlying_security_id"
    t.text "variable_rate_frequency"
    t.text "income_currency"
    t.text "sector_entity_id"
    t.string "source_name", limit: 16
    t.decimal "weight", precision: 18, scale: 10
    t.string "composite_ticker", limit: 32
    t.index ["etfg_date"], name: "bbh_pval_date"
  end

  create_table "bbh_pval_template", id: false, force: :cascade do |t|
    t.text "accounting_basis"
    t.text "accounting_date"
    t.text "asset_currency"
    t.text "average_days_to_maturity"
    t.text "average_years_to_maturity"
    t.text "bbh_security_id"
    t.text "base_amortized_cost"
    t.text "base_currency_code"
    t.text "base_interest_receivable"
    t.text "base_market_value"
    t.text "base_market_value_change"
    t.text "base_notional_amount"
    t.text "base_original_cost"
    t.text "base_price"
    t.text "base_price_change"
    t.text "base_total_unrealized_gain"
    t.text "base_total_unrealized_loss"
    t.text "base_unit_cost"
    t.text "base_unrealized_currency_gain"
    t.text "base_unrealized_currency_loss"
    t.text "base_unrealized_security_gain"
    t.text "base_unrealized_security_loss"
    t.text "bloomberg_industry_group"
    t.text "bloomberg_industry_sector"
    t.text "bloomberg_industry_subgroup_code"
    t.text "bloomberg_industry_subgroup_description"
    t.text "cpi_index_ratio"
    t.text "cusip"
    t.text "close_event_id"
    t.text "cost_method"
    t.text "country_code"
    t.text "country_description"
    t.text "currency_description"
    t.text "current_face"
    t.text "custody_head_account_number"
    t.text "days_to_maturity"
    t.text "entity_name"
    t.text "entity_number"
    t.text "fx_rate"
    t.text "isin"
    t.text "industry_type_code"
    t.text "interest_rate"
    t.text "investment_type_code"
    t.text "investment_type_description"
    t.text "issue_date"
    t.text "issue_price"
    t.text "local_amortized_cost"
    t.text "local_currency_code"
    t.text "local_market_value"
    t.text "local_market_value_change"
    t.text "local_notional_amount"
    t.text "local_original_cost"
    t.text "local_price"
    t.text "local_price_change"
    t.text "local_price_change_percent"
    t.text "local_unit_cost"
    t.text "local_unrealized_security_gain"
    t.text "local_unrealized_security_loss"
    t.text "long_short_indicator"
    t.text "maturity_date"
    t.text "maturity_tier_code"
    t.text "maturity_tier_description"
    t.text "monthly_daily_indicator"
    t.text "moodys_rating"
    t.text "moodys_rating_date"
    t.text "nav"
    t.text "net_assets_excluding_securities"
    t.text "open_event_id"
    t.text "original_face"
    t.text "per_share_nav_impact"
    t.text "percent_change_in_market_value"
    t.text "percent_mv"
    t.text "percent_tna"
    t.text "previous_accounting_date"
    t.text "previous_base_amortized_cost"
    t.text "previous_base_market_value"
    t.text "previous_base_price"
    t.text "previous_base_unit_cost"
    t.text "previous_base_unrealized_gl"
    t.text "previous_capital_gl"
    t.text "previous_currency_gl"
    t.text "previous_fx_rate"
    t.text "previous_local_amortized_cost"
    t.text "previous_local_market_value"
    t.text "previous_local_price"
    t.text "previous_local_unit_cost"
    t.text "previous_local_unrealized_gl"
    t.text "previous_nav"
    t.text "previous_outstanding_settled_shares"
    t.text "previous_price_date"
    t.text "previous_quantity"
    t.text "previous_shares_outstanding"
    t.text "previous_total_base_market_value"
    t.text "price_effective_date"
    t.text "price_factor"
    t.text "primary_traded_exchange_by_security_by_fund"
    t.text "private_placement_indicator"
    t.text "processing_security_type"
    t.text "quantity"
    t.text "quantity_change"
    t.text "quantity_scale"
    t.text "report_type"
    t.text "sedol"
    t.text "sic_code"
    t.text "securities_at_market_value"
    t.text "restricted_flag"
    t.text "security_alias_id"
    t.text "security_description"
    t.text "security_id"
    t.text "security_id_type"
    t.text "security_long_description"
    t.text "security_type_code"
    t.text "security_type_description"
    t.text "settlement_date"
    t.text "shares_outstanding"
    t.text "source"
    t.text "state_code"
    t.text "sub_security_type_code"
    t.text "sub_security_type_description"
    t.text "ticker_symbol"
    t.text "total_base_market_value"
    t.text "total_current_assets"
    t.text "total_current_liabilities"
    t.text "total_dividend_marked_to_market"
    t.text "total_forward_currency_marked_to_market"
    t.text "total_interest_marked_to_market"
    t.text "total_net_assets"
    t.text "total_outstanding_settled_shares"
    t.text "trade_date"
    t.text "trade_date_fx_rate"
    t.text "underlying_security_description"
    t.text "underlying_security_id"
    t.text "variable_rate_frequency"
    t.text "income_currency"
    t.text "sector_entity_id"
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

  create_table "bny_hold", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "portfolio_as_of_date"
    t.text "custody_fund_number"
    t.text "fund_cusip"
    t.text "fund_name"
    t.text "security_identifier"
    t.text "security_description"
    t.text "share_par_value"
    t.text "base_market_value"
    t.text "coupon_rate"
    t.text "maturity_date"
    t.text "portfolio_base_currency"
    t.text "local_market_value"
    t.text "local_currency"
    t.text "cost_basis"
    t.text "country"
    t.string "source_name", limit: 64
    t.index ["etfg_date"], name: "bny_hold_etfg_date"
  end

  create_table "bny_hold_template", id: false, force: :cascade do |t|
    t.date "portfolio_as_of_date"
    t.text "custody_fund_number"
    t.text "fund_cusip"
    t.text "fund_name"
    t.text "security_identifier"
    t.text "security_description"
    t.text "share_par_value"
    t.text "base_market_value"
    t.text "coupon_rate"
    t.text "maturity_date"
    t.text "portfolio_base_currency"
    t.text "local_market_value"
    t.text "local_currency"
    t.text "cost_basis"
    t.text "country"
  end

  create_table "bny_lookups", id: false, force: :cascade do |t|
    t.string "fund_id", limit: 32, null: false
    t.string "account_name", limit: 128, null: false
    t.string "ticker", limit: 32, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.index ["fund_id"], name: "index_bny_lookups_on_fund_id", unique: true
  end

  create_table "bny_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "custody_fund_number"
    t.text "fund_name"
    t.text "fund_sedol"
    t.text "fund_isin"
    t.text "class_identifier"
    t.date "valuation_date"
    t.text "base_currency"
    t.decimal "base_currency_nav", precision: 22, scale: 6
    t.text "base_ccy_total_net_assets"
    t.text "class_currency"
    t.text "class_currency_nav"
    t.text "class_ccy_total_net_assets"
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.text "cash"
    t.text "fund_cusip"
    t.text "fund_ticker"
    t.index ["etfg_date"], name: "bny_nav_etfg_date"
  end

  create_table "bny_nav_template", id: false, force: :cascade do |t|
    t.text "custody_fund_number"
    t.text "fund_name"
    t.text "fund_sedol"
    t.text "fund_isin"
    t.text "class_identifier"
    t.date "valuation_date"
    t.text "base_currency"
    t.decimal "base_currency_nav", precision: 22, scale: 6
    t.text "base_ccy_total_net_assets"
    t.text "class_currency"
    t.text "class_currency_nav"
    t.text "class_ccy_total_net_assets"
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.text "cash"
    t.text "fund_cusip"
    t.text "fund_ticker"
  end

  create_table "citi_basket", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "ticker"
    t.text "fund_cusip"
    t.text "security_cusip"
    t.text "security_isin"
    t.text "security_sedol"
    t.text "stock_ticker"
    t.text "security_description"
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.text "fult_val"
  end

  create_table "citi_basket_template", id: false, force: :cascade do |t|
    t.text "ticker"
    t.text "fund_cusip"
    t.text "security_cusip"
    t.text "security_isin"
    t.text "security_sedol"
    t.text "stock_ticker"
    t.text "security_description"
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.text "fult_val"
  end

  create_table "citi_hold", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "ticker"
    t.text "fund_cusip"
    t.text "security_cusip"
    t.text "security_isin"
    t.text "security_sedol"
    t.text "stock_ticker"
    t.text "security_description"
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.text "futval"
    t.string "source_name", limit: 16
  end

  create_table "citi_hold_template", id: false, force: :cascade do |t|
    t.text "ticker"
    t.text "fund_cusip"
    t.text "security_cusip"
    t.text "security_isin"
    t.text "security_sedol"
    t.text "stock_ticker"
    t.text "security_description"
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.text "futval"
  end

  create_table "citi_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "ticker"
    t.text "cusip"
    t.date "date"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "outstanding_shares_par", precision: 22, scale: 6
    t.decimal "distributed_income", precision: 22, scale: 6
    t.decimal "distributed_gain_loss", precision: 22, scale: 6
    t.decimal "total_assets", precision: 22, scale: 6
    t.decimal "net_assets", precision: 22, scale: 6
    t.text "futval"
    t.string "source_name", limit: 16
  end

  create_table "citi_nav_template", id: false, force: :cascade do |t|
    t.text "ticker"
    t.text "cusip"
    t.date "date"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "outstanding_shares_par", precision: 22, scale: 6
    t.decimal "distributed_income", precision: 22, scale: 6
    t.decimal "distributed_gain_loss", precision: 22, scale: 6
    t.decimal "total_assets", precision: 22, scale: 6
    t.decimal "net_assets", precision: 22, scale: 6
    t.text "futval"
  end

  create_table "etfmg_hold", force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "composite_ticker", limit: 32
    t.string "constituent_ticker", limit: 64
    t.string "cusip", limit: 9
    t.string "security_name", limit: 128
    t.decimal "shares", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "weightings", precision: 18, scale: 10
    t.boolean "valid_cusip", default: false, null: false
    t.index ["etfg_date", "composite_ticker"], name: "etfmg_hold_date_composite"
    t.index ["etfg_date", "cusip"], name: "etfmg_hold_date_cusip"
    t.index ["etfg_date"], name: "etfmg_hold_etfg_date"
  end

  create_table "etfmg_hold_template", id: false, force: :cascade do |t|
    t.text "as_of_date"
    t.text "account"
    t.text "stock_ticker"
    t.text "cusip"
    t.text "security_name"
    t.text "shares"
    t.text "price"
    t.text "market_value"
    t.text "weightings"
    t.text "net_assets"
    t.text "shares_outstanding"
    t.text "creation_units"
    t.text "money_market_flag"
  end

  create_table "etfmg_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "composite_ticker", limit: 32
    t.decimal "net_assets", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "creation_units", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
    t.index ["etfg_date", "composite_ticker"], name: "etfmg_nav_date_ticker"
    t.index ["etfg_date"], name: "etfmg_nav_etfg_date"
  end

  create_table "firsttrust_etn", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.string "cusip", limit: 9
    t.decimal "tas", precision: 22, scale: 6
    t.string "ticker", limit: 32
    t.string "fund_name", limit: 128
    t.date "as_of_date"
    t.decimal "projected_nav", precision: 22, scale: 6
    t.decimal "income_distribution_rate", precision: 22, scale: 6
    t.date "reinvest_date"
    t.decimal "accrued_dividend", precision: 22, scale: 6
    t.decimal "long_term_capital_gain", precision: 22, scale: 6
    t.decimal "mid_term_capital_gain", precision: 22, scale: 6
    t.decimal "short_term_capital_gain", precision: 22, scale: 6
    t.decimal "daily_dividend", precision: 22, scale: 6
    t.decimal "sec_yield", precision: 22, scale: 6
    t.decimal "total_net_assets", precision: 22, scale: 6
    t.decimal "total_shares_outstanding", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
  end

  create_table "firsttrust_etn_template", id: false, force: :cascade do |t|
    t.text "cusip"
    t.text "tas"
    t.text "ticker"
    t.text "fund_name"
    t.text "as_of_date"
    t.text "projected_nav"
    t.text "income_distribution_rate"
    t.text "reinvest_date"
    t.text "accrued_dividend"
    t.text "long_term_capital_gain"
    t.text "mid_term_capital_gain"
    t.text "short_term_capital_gain"
    t.text "daily_dividend"
    t.text "sec_yield"
    t.text "total_net_assets"
    t.text "total_shares_outstanding"
    t.text "nav"
  end

  create_table "gemini_ms", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "unique_id"
    t.text "fund_name"
    t.text "cusip"
    t.text "ticker"
    t.date "morning_star_date"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "another_value", precision: 22, scale: 6
    t.decimal "another_value_2", precision: 22, scale: 6
    t.decimal "anoter_value_3", precision: 22, scale: 10
    t.text "futval_7"
    t.text "futval_6"
    t.text "futval_5"
    t.text "futval_4"
    t.text "futval_3"
    t.decimal "some_mostly_zero_number", precision: 18, scale: 6
    t.text "futval_2"
    t.text "futval_1"
    t.text "futval0"
    t.text "futval1"
    t.text "futval2"
    t.text "futval3"
    t.text "futval4"
    t.text "futval5"
    t.text "futval6"
    t.text "futval7"
    t.text "futval8"
    t.text "futval9"
    t.text "futval10"
    t.decimal "shares_outstanding", precision: 18, scale: 6
  end

  create_table "gemini_ms_template", id: false, force: :cascade do |t|
    t.text "unique_id"
    t.text "fund_name"
    t.text "cusip"
    t.text "ticker"
    t.date "morning_star_date"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "another_value", precision: 22, scale: 6
    t.decimal "another_value_2", precision: 22, scale: 6
    t.decimal "anoter_value_3", precision: 22, scale: 10
    t.text "futval_7"
    t.text "futval_6"
    t.text "futval_5"
    t.text "futval_4"
    t.text "futval_3"
    t.decimal "some_mostly_zero_number", precision: 18, scale: 6
    t.text "futval_2"
    t.text "futval_1"
    t.text "futval0"
    t.text "futval1"
    t.text "futval2"
    t.text "futval3"
    t.text "futval4"
    t.text "futval5"
    t.text "futval6"
    t.text "futval7"
    t.text "futval8"
    t.text "futval9"
    t.text "futval10"
    t.decimal "shares_outstanding", precision: 18, scale: 6
  end

  create_table "gemini_pos", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "gemini_date"
    t.text "account_number"
    t.text "account_name"
    t.text "security_number"
    t.text "security_description"
    t.decimal "shares", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "coupon_rate", precision: 22, scale: 6
    t.date "maturitydate"
    t.text "tmv_currency"
    t.decimal "traded_market_value", precision: 22, scale: 6
    t.text "acb_currency"
    t.decimal "amortized_cost_base", precision: 22, scale: 6
    t.text "country"
  end

  create_table "gemini_pos_template", id: false, force: :cascade do |t|
    t.date "gemini_date"
    t.text "account_number"
    t.text "account_name"
    t.text "security_number"
    t.text "security_description"
    t.decimal "shares", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "coupon_rate", precision: 22, scale: 10
    t.date "maturitydate"
    t.text "tmv_currency"
    t.decimal "traded_market_value", precision: 22, scale: 6
    t.text "acb_currency"
    t.decimal "amortized_cost_base", precision: 22, scale: 6
    t.text "country"
  end

  create_table "gsam_etf", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "gsam_date"
    t.text "account_name"
    t.text "ticker"
    t.text "account_number"
    t.decimal "nav", precision: 18, scale: 6
    t.decimal "net_assets", precision: 18, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 6
    t.decimal "income_distribution_rate_per_share", precision: 18, scale: 6
    t.decimal "long_term_capital_distribution_rate_per_share", precision: 18, scale: 6
    t.decimal "short_term_capital_distribution_rate_per_share", precision: 18, scale: 6
    t.text "fut_val"
  end

  create_table "gsam_etf_template", id: false, force: :cascade do |t|
    t.date "gsam_date"
    t.text "account_name"
    t.text "ticker"
    t.text "account_number"
    t.decimal "nav", precision: 18, scale: 6
    t.decimal "net_assets", precision: 18, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 6
    t.decimal "income_distribution_rate_per_share", precision: 18, scale: 6
    t.decimal "long_term_capital_distribution_rate_per_share", precision: 18, scale: 6
    t.decimal "short_term_capital_distribution_rate_per_share", precision: 18, scale: 6
    t.text "fut_val"
  end

  create_table "gsam_portfolio", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "gsam_date"
    t.text "account_num"
    t.text "account_name"
    t.text "security_number"
    t.text "security_name"
    t.decimal "shares", precision: 18, scale: 6
    t.decimal "usd_market_value", precision: 18, scale: 6
    t.text "coupon"
    t.text "maturity_date"
    t.text "fund_currency"
  end

  create_table "gsam_portfolio_template", id: false, force: :cascade do |t|
    t.date "gsam_date"
    t.text "account_num"
    t.text "account_name"
    t.text "security_number"
    t.text "security_name"
    t.decimal "shares", precision: 18, scale: 6
    t.decimal "usd_market_value", precision: 18, scale: 6
    t.text "coupon"
    t.text "maturity_date"
    t.text "fund_currency"
  end

  create_table "hod_nav", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "hod_date", null: false
    t.string "ticker", limit: 32, null: false
    t.decimal "call_implied_vol", precision: 22, scale: 6
    t.decimal "put_implied_vol", precision: 22, scale: 6
    t.decimal "mean_implied_vol", precision: 22, scale: 6
    t.decimal "call_volume", precision: 22, scale: 6
    t.decimal "put_volume", precision: 22, scale: 6
    t.decimal "call_open_interest", precision: 22, scale: 6
    t.decimal "put_open_interest", precision: 22, scale: 6
  end

  create_table "hod_template", id: false, force: :cascade do |t|
    t.text "ticker"
    t.text "hod_date"
    t.text "call_iv"
    t.text "put_iv"
    t.text "mean_iv"
    t.text "call_vol"
    t.text "put_vol"
    t.text "call_oi"
    t.text "put_oi"
  end

  create_table "jpm_flex_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.string "fund_name", limit: 128
    t.string "fund_number", limit: 32
    t.string "ticker", limit: 32
    t.string "cusip", limit: 9
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "pop", precision: 22, scale: 6
    t.decimal "nav_change", precision: 22, scale: 6
    t.decimal "net_assets", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "distribution_factor", precision: 22, scale: 6
    t.decimal "st_cap_gains", precision: 22, scale: 6
    t.decimal "lt_cap_gains", precision: 22, scale: 6
  end

  create_table "jpm_flex_nav_template", id: false, force: :cascade do |t|
    t.text "fund_name"
    t.text "fund_number"
    t.text "ticker"
    t.text "cusip"
    t.text "nav"
    t.text "pop"
    t.text "nav_change"
    t.text "net_assets"
    t.text "market_value"
    t.text "shares_outstanding"
    t.text "distribution_factor"
    t.text "st_cap_gains"
    t.text "lt_cap_gains"
  end

  create_table "jpm_flex_pos", force: :cascade do |t|
    t.date "etfg_date"
    t.string "account_number", limit: 32
    t.string "composite_ticker", limit: 32
    t.string "account_name", limit: 128
    t.string "cass_protected", limit: 32
    t.string "security_id", limit: 32
    t.string "isin", limit: 12
    t.string "occ_id", limit: 32
    t.string "cash_account_number", limit: 32
    t.string "cash_account_name", limit: 128
    t.string "cash_account_ccy_code", limit: 3
    t.string "security_name", limit: 255
    t.decimal "coupon_rate", precision: 22, scale: 6
    t.date "maturity_date"
    t.string "pool_number", limit: 32
    t.string "branch_code", limit: 32
    t.string "branch_name", limit: 32
    t.string "dgsd_eligible", limit: 32
    t.decimal "settled_units", precision: 22, scale: 6
    t.decimal "total_units", precision: 22, scale: 6
    t.decimal "awaiting_receipt", precision: 22, scale: 6
    t.decimal "awaiting_delivery", precision: 22, scale: 6
    t.decimal "market_price", precision: 22, scale: 10
    t.date "price_date"
    t.decimal "exchange_rate", precision: 22, scale: 10
    t.string "country_code", limit: 2
    t.decimal "settled_market_value_local", precision: 22, scale: 6
    t.decimal "settled_market_value_base", precision: 22, scale: 6
    t.string "local_currency", limit: 3
    t.string "base_currency", limit: 3
    t.decimal "total_market_value_local", precision: 22, scale: 6
    t.decimal "total_market_value_base", precision: 22, scale: 6
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "jpm_flex_pos_template", id: false, force: :cascade do |t|
    t.text "account_number"
    t.text "account_name"
    t.text "cass_protected"
    t.text "security_id"
    t.text "isin"
    t.text "occ_id"
    t.text "cash_account_number"
    t.text "cash_account_name"
    t.text "cash_account_ccy_code"
    t.text "security_name"
    t.text "coupon_rate"
    t.text "maturity_date"
    t.text "pool_number"
    t.text "branch_code"
    t.text "branch_name"
    t.text "dgsd_eligible"
    t.text "settled_units"
    t.text "total_units"
    t.text "awaiting_receipt"
    t.text "awaiting_delivery"
    t.text "market_price"
    t.text "price_date"
    t.text "exchange_rate"
    t.text "country_code"
    t.text "settled_market_value_local"
    t.text "settled_market_value_base"
    t.text "local_currency"
    t.text "base_currency"
    t.text "total_market_value_local"
    t.text "total_market_value_base"
  end

  create_table "jpm_lookups", force: :cascade do |t|
    t.string "source", limit: 16, null: false
    t.string "account_number", limit: 32, null: false
    t.string "account_name", limit: 128
    t.string "ticker", limit: 32, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.index ["source", "account_number"], name: "index_jpm_lookups_on_source_and_account_number", unique: true
  end

  create_table "jpm_prod_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "fund_name", limit: 128
    t.string "ticker", limit: 64
    t.string "cusip", limit: 9
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "previous_nav", precision: 22, scale: 6
    t.decimal "nav_change", precision: 22, scale: 6
    t.decimal "pct_nav_change", precision: 22, scale: 6
    t.decimal "net_assets", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "distribution_factor", precision: 22, scale: 6
    t.decimal "distributed_income", precision: 22, scale: 6
    t.decimal "daily_yield", precision: 22, scale: 6
    t.decimal "st_cap_gains", precision: 22, scale: 6
    t.decimal "lt_cap_gains", precision: 22, scale: 6
  end

  create_table "jpm_prod_nav_template", id: false, force: :cascade do |t|
    t.text "fund_name"
    t.text "ticker"
    t.text "cusip"
    t.text "nav"
    t.text "previous_nav"
    t.text "nav_change"
    t.text "pct_nav_change"
    t.text "net_assets"
    t.text "shares_outstanding"
    t.text "distribution_factor"
    t.text "distributed_income"
    t.text "daily_yield"
    t.text "st_cap_gains"
    t.text "lt_cap_gains"
    t.text "as_of_date"
  end

  create_table "jpm_prod_pos", force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.string "account_number", limit: 32
    t.string "composite_ticker", limit: 32
    t.string "account_name", limit: 128
    t.string "account_status", limit: 32
    t.string "base_currency", limit: 3
    t.string "asset_id", limit: 32
    t.string "security_qualifier", limit: 32
    t.string "security_description", limit: 255
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "market_price", precision: 22, scale: 6
    t.decimal "original_cost", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "unrealized_gain_loss", precision: 22, scale: 6
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "jpms_ffcm", force: :cascade do |t|
    t.date "etfg_date"
    t.string "account_number", limit: 32
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.string "asset_id", limit: 9
    t.string "constituent_name", limit: 128
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "coupon_rate", precision: 22, scale: 6
    t.date "maturity_date"
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "jpms_ffcm_template", id: false, force: :cascade do |t|
    t.text "effective_date"
    t.text "account_number"
    t.text "account_name"
    t.text "asset_id"
    t.text "security_description"
    t.text "shares_par"
    t.text "market_value"
    t.text "coupon_rate"
    t.text "maturity_date"
    t.text "base_currency"
  end

  create_table "jpms_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "fund_name"
    t.text "ticker"
    t.text "cusip"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "pop", precision: 22, scale: 6
    t.decimal "nav_change", precision: 22, scale: 6
    t.decimal "net_assets", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 6
    t.text "distribution_factor"
    t.text "st_cap_gains"
    t.text "lt_cap_gains"
    t.string "source_name", limit: 32
  end

  create_table "jpms_nav_template", id: false, force: :cascade do |t|
    t.text "fund_name"
    t.text "ticker"
    t.text "cusip"
    t.text "nav"
    t.text "pop"
    t.text "nav_change"
    t.text "net_assets"
    t.text "shares_outstanding"
    t.text "distribution_factor"
    t.text "st_cap_gains"
    t.text "lt_cap_gains"
  end

  create_table "jpms_profund", force: :cascade do |t|
    t.date "etfg_date"
    t.string "account_number", limit: 32
    t.string "composite_ticker", limit: 32
    t.string "account_name", limit: 128
    t.string "account_status", limit: 32
    t.string "base_currency", limit: 3
    t.string "asset_id", limit: 32
    t.string "security_qualifier", limit: 32
    t.string "security_description", limit: 255
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "market_price", precision: 22, scale: 6
    t.decimal "original_cost", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "unrealized_gain_loss", precision: 22, scale: 6
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "jpms_profund_template", id: false, force: :cascade do |t|
    t.text "account_number"
    t.text "account_name"
    t.text "account_status"
    t.text "base_currency"
    t.text "asset_id"
    t.text "security_qualifier"
    t.text "security_description"
    t.text "shares_par"
    t.text "market_price"
    t.text "original_cost"
    t.text "market_value"
    t.text "unrealized_gain_loss"
  end

  create_table "jpms_reo", force: :cascade do |t|
    t.date "etfg_date"
    t.string "account_number", limit: 32
    t.string "composite_ticker", limit: 32
    t.string "account_name", limit: 128
    t.string "base_currency", limit: 16
    t.string "asset_id", limit: 32
    t.string "security_description", limit: 255
    t.decimal "shares_par", precision: 22, scale: 6
    t.decimal "market_price", precision: 22, scale: 6
    t.decimal "original_cost", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "unrealized_gain_loss", precision: 22, scale: 6
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "jpms_reo_template", id: false, force: :cascade do |t|
    t.text "account_number"
    t.text "account_name"
    t.text "base_currency"
    t.text "asset_id"
    t.text "security_description"
    t.text "shares_par"
    t.text "market_price"
    t.text "original_cost"
    t.text "market_value"
    t.text "unrealized_gain_loss"
  end

  create_table "missing_nav", id: false, force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.string "ticker", limit: 32, null: false
    t.string "country", limit: 3, null: false
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "shares", precision: 22, scale: 6
    t.index ["etfg_date", "ticker", "country"], name: "compound_key", unique: true
  end

  create_table "missing_nav_template", id: false, force: :cascade do |t|
    t.text "as_of_date"
    t.text "ticker"
    t.text "country"
    t.text "nav"
    t.text "shares"
  end

  create_table "sei_blackbar", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "parent_id"
    t.text "fundid"
    t.text "ticker"
    t.text "exchange"
    t.text "sei_name"
    t.text "classname"
    t.text "inception_date"
    t.date "daily_data_date"
    t.date "daily_data_time"
    t.decimal "latest_price_nav", precision: 18, scale: 6
    t.decimal "premium_discount_dlr", precision: 18, scale: 10
    t.decimal "premium_discount_prct", precision: 18, scale: 10
    t.decimal "greatest_prem_prct", precision: 18, scale: 10
    t.decimal "greatest_disc_prct", precision: 18, scale: 10
    t.decimal "one_day_dlr", precision: 18, scale: 10
    t.decimal "one_day_prct", precision: 18, scale: 10
    t.decimal "one_day_return", precision: 18, scale: 10
    t.decimal "month_to_date_return", precision: 18, scale: 10
    t.decimal "yield_sec_30", precision: 18, scale: 10
    t.decimal "assets", precision: 18, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 4
    t.date "month_end_date"
    t.decimal "one_month_m", precision: 18, scale: 10
    t.decimal "three_month_m", precision: 18, scale: 10
    t.decimal "six_month_m", precision: 18, scale: 10
    t.decimal "year_to_date_m", precision: 18, scale: 10
    t.decimal "one_year_m", precision: 18, scale: 10
    t.decimal "three_year_m", precision: 18, scale: 10
    t.decimal "five_year_m", precision: 18, scale: 10
    t.decimal "ten_year_m", precision: 18, scale: 10
    t.decimal "since_inception_m", precision: 18, scale: 10
    t.decimal "since_inception_cum_m", precision: 18, scale: 10
    t.date "quarter_end_date"
    t.decimal "one_month_q", precision: 18, scale: 10
    t.decimal "three_month_q", precision: 18, scale: 10
    t.decimal "year_to_date_q", precision: 18, scale: 10
    t.decimal "one_year_q", precision: 18, scale: 10
    t.decimal "three_year_q", precision: 18, scale: 10
    t.decimal "five_year_q", precision: 18, scale: 10
    t.decimal "ten_year_q", precision: 18, scale: 10
    t.decimal "since_inception_q", precision: 18, scale: 10
    t.decimal "since_inception_cum_q", precision: 18, scale: 10
    t.decimal "expense_ratio_bps", precision: 18, scale: 6
    t.decimal "yield_1_month_cmp", precision: 18, scale: 10
    t.decimal "yield_1_month_simple", precision: 18, scale: 10
    t.decimal "yield_12_month_cmp", precision: 18, scale: 10
    t.decimal "yield_12_month_simple", precision: 18, scale: 10
    t.decimal "yield_current", precision: 18, scale: 10
    t.text "benchmark_id"
    t.decimal "m_benchmark_inc_ann_rtn", precision: 18, scale: 10
    t.decimal "m_benchmark_inc_cum_rtn", precision: 18, scale: 10
    t.decimal "q_benchmark_inc_ann_rtn", precision: 18, scale: 10
    t.decimal "q_benchmark_inc_cum_rtn", precision: 18, scale: 10
    t.decimal "volume", precision: 18, scale: 6
  end

  create_table "sei_blackbar_template", id: false, force: :cascade do |t|
    t.text "parent_id"
    t.text "fundid"
    t.text "ticker"
    t.text "exchange"
    t.text "sei_name"
    t.text "classname"
    t.text "inception_date"
    t.date "daily_data_date"
    t.date "daily_data_time"
    t.decimal "latest_price_nav", precision: 18, scale: 6
    t.decimal "premium_discount_dlr", precision: 18, scale: 10
    t.decimal "premium_discount_prct", precision: 18, scale: 10
    t.decimal "greatest_prem_prct", precision: 18, scale: 10
    t.decimal "greatest_disc_prct", precision: 18, scale: 10
    t.decimal "one_day_dlr", precision: 18, scale: 10
    t.decimal "one_day_prct", precision: 18, scale: 10
    t.decimal "one_day_return", precision: 18, scale: 10
    t.decimal "month_to_date_return", precision: 18, scale: 10
    t.decimal "yield_sec_30", precision: 18, scale: 10
    t.decimal "assets", precision: 18, scale: 6
    t.decimal "shares_outstanding", precision: 18, scale: 4
    t.date "month_end_date"
    t.decimal "one_month_m", precision: 18, scale: 10
    t.decimal "three_month_m", precision: 18, scale: 10
    t.decimal "six_month_m", precision: 18, scale: 10
    t.decimal "year_to_date_m", precision: 18, scale: 10
    t.decimal "one_year_m", precision: 18, scale: 10
    t.decimal "three_year_m", precision: 18, scale: 10
    t.decimal "five_year_m", precision: 18, scale: 10
    t.decimal "ten_year_m", precision: 18, scale: 10
    t.decimal "since_inception_m", precision: 18, scale: 10
    t.decimal "since_inception_cum_m", precision: 18, scale: 10
    t.date "quarter_end_date"
    t.decimal "one_month_q", precision: 18, scale: 10
    t.decimal "three_month_q", precision: 18, scale: 10
    t.decimal "year_to_date_q", precision: 18, scale: 10
    t.decimal "one_year_q", precision: 18, scale: 10
    t.decimal "three_year_q", precision: 18, scale: 10
    t.decimal "five_year_q", precision: 18, scale: 10
    t.decimal "ten_year_q", precision: 18, scale: 10
    t.decimal "since_inception_q", precision: 18, scale: 10
    t.decimal "since_inception_cum_q", precision: 18, scale: 10
    t.decimal "expense_ratio_bps", precision: 18, scale: 6
    t.decimal "yield_1_month_cmp", precision: 18, scale: 10
    t.decimal "yield_1_month_simple", precision: 18, scale: 10
    t.decimal "yield_12_month_cmp", precision: 18, scale: 10
    t.decimal "yield_12_month_simple", precision: 18, scale: 10
    t.decimal "yield_current", precision: 18, scale: 10
    t.text "benchmark_id"
    t.decimal "m_benchmark_inc_ann_rtn", precision: 18, scale: 10
    t.decimal "m_benchmark_inc_cum_rtn", precision: 18, scale: 10
    t.decimal "q_benchmark_inc_ann_rtn", precision: 18, scale: 10
    t.decimal "q_benchmark_inc_cum_rtn", precision: 18, scale: 10
    t.decimal "volume", precision: 18, scale: 6
  end

  create_table "sei_holdings", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "portfolio_id"
    t.text "sei_fund_nm"
    t.text "cusip"
    t.date "sei_date"
    t.text "security_type"
    t.text "security_number"
    t.text "security_description"
    t.decimal "shares", precision: 18, scale: 6
    t.decimal "market_value", precision: 18, scale: 6
    t.decimal "percent_of_market_value", precision: 18, scale: 6
    t.decimal "percent_of_net_assets", precision: 18, scale: 6
    t.text "ticker"
  end

  create_table "sei_holdings_template", id: false, force: :cascade do |t|
    t.text "porfolio_id"
    t.text "sei_fund_nm"
    t.text "cusip"
    t.date "sei_date"
    t.text "security_type"
    t.text "security_number"
    t.text "security_description"
    t.decimal "shares", precision: 18, scale: 6
    t.decimal "market_value", precision: 18, scale: 6
    t.decimal "percent_of_market_value", precision: 18, scale: 6
    t.decimal "percent_of_net_assets", precision: 18, scale: 6
    t.text "ticker"
  end

  create_table "short_squeeze_template", id: false, force: :cascade do |t|
    t.text "symbol"
    t.text "company"
    t.text "total_short_interest"
    t.text "days_to_cover"
    t.text "short_pct_of_float"
    t.text "short_prior_mo"
    t.text "record_date"
  end

  create_table "short_squeezes", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "record_date", null: false
    t.string "symbol", limit: 32, null: false
    t.string "company", limit: 128
    t.decimal "total_short_interest", precision: 22, scale: 6
    t.decimal "days_to_cover", precision: 22, scale: 6
    t.decimal "short_pct_of_float", precision: 22, scale: 6
    t.decimal "short_prior_mo", precision: 22, scale: 6
  end

  create_table "ssc_lookups", force: :cascade do |t|
    t.string "fund_id", limit: 4, null: false
    t.string "fund_name", limit: 128
    t.string "ticker", limit: 32, null: false
    t.date "effective_date"
    t.date "expiration_date"
    t.string "fund_id_alias", limit: 4
  end

  create_table "ssc_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.string "fund_type", limit: 4
    t.string "fund_id", limit: 4
    t.string "fund_name", limit: 128
    t.string "base_currency", limit: 3
    t.string "distribution_frequency", limit: 1
    t.date "nav_date"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "nav_change", precision: 22, scale: 6
    t.decimal "offer_price", precision: 22, scale: 6
    t.decimal "offer_price_change", precision: 22, scale: 6
    t.decimal "net_assets", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "app_dep", precision: 22, scale: 6
    t.decimal "income_distribution", precision: 22, scale: 6
    t.decimal "div_shares", precision: 22, scale: 6
    t.decimal "daily_div_rate", precision: 22, scale: 6
    t.decimal "div_rate_change", precision: 22, scale: 6
    t.decimal "net_shares_outstanding", precision: 22, scale: 6
    t.decimal "seven_day_yield", precision: 22, scale: 6
    t.decimal "seven_day_eff_yield", precision: 22, scale: 6
    t.decimal "avg_days_mat", precision: 22, scale: 6
    t.decimal "total_assets", precision: 22, scale: 6
    t.string "composite_fund_number", limit: 32
    t.string "cls_class_code", limit: 32
    t.string "cls_class_name", limit: 128
    t.string "source_name", limit: 32
    t.boolean "redundant", default: false, null: false
  end

  create_table "ssc_nav_template", id: false, force: :cascade do |t|
    t.text "fund_type"
    t.text "fund_id"
    t.text "fund_name"
    t.text "base_currency"
    t.text "distribution_frequency"
    t.text "nav_date"
    t.text "nav"
    t.text "nav_change"
    t.text "offer_price"
    t.text "offer_price_change"
    t.text "net_assets"
    t.text "market_value"
    t.text "app_dep"
    t.text "income_distribution"
    t.text "div_shares"
    t.text "daily_div_rate"
    t.text "div_rate_change"
    t.text "net_shares_outstanding"
    t.text "seven_day_yield"
    t.text "seven_day_eff_yield"
    t.text "avg_days_mat"
    t.text "total_assets"
    t.text "composite_fund_number"
    t.text "cls_class_code"
    t.text "cls_class_name"
  end

  create_table "ssc_pos", force: :cascade do |t|
    t.date "etfg_date"
    t.string "fund_type", limit: 4
    t.string "fund_id", limit: 4
    t.string "base_country", limit: 2
    t.string "base_currency", limit: 3
    t.date "calendar_date"
    t.string "asset_id", limit: 64
    t.string "alt_asset_id_type1", limit: 3
    t.string "alt_asset_id1", limit: 12
    t.string "alt_asset_id_type2", limit: 3
    t.string "alt_asset_id2", limit: 12
    t.string "dtc_cusip", limit: 9
    t.string "ticker", limit: 64
    t.string "issue_long_name", limit: 128
    t.string "invest_ind", limit: 32
    t.string "asset_group", limit: 32
    t.string "position_type", limit: 32
    t.string "investment_type", limit: 32
    t.string "state_code", limit: 32
    t.string "incorporated_country", limit: 2
    t.string "issued_country", limit: 2
    t.string "trade_country", limit: 2
    t.string "nratax_country", limit: 2
    t.date "issue_date"
    t.date "maturity_date"
    t.decimal "days_to_maturity", precision: 22, scale: 6
    t.decimal "original_coupon_rate", precision: 22, scale: 6
    t.decimal "pos_int_rate", precision: 22, scale: 6
    t.date "var_rate_change_date"
    t.string "var_rate_frequency", limit: 16
    t.string "moody_rating", limit: 32
    t.string "snp_rating", limit: 32
    t.string "major_industry", limit: 64
    t.string "minor_industry", limit: 64
    t.string "pool_type", limit: 32
    t.string "lot_account_num", limit: 32
    t.string "repo_num", limit: 32
    t.decimal "total_lots", precision: 22, scale: 6
    t.date "trade_date"
    t.date "settlement_date"
    t.string "issue_class", limit: 64
    t.string "report_class", limit: 64
    t.string "call_put_ind", limit: 1
    t.decimal "orig_strike_price", precision: 22, scale: 6
    t.decimal "curr_strike_price", precision: 22, scale: 6
    t.decimal "share_par_qty", precision: 22, scale: 6
    t.decimal "contracts_qty", precision: 22, scale: 6
    t.decimal "org_face_pos_qty", precision: 22, scale: 6
    t.decimal "untcst_btl", precision: 22, scale: 6
    t.decimal "untcst_ltl", precision: 22, scale: 6
    t.decimal "cstorg_btl", precision: 22, scale: 6
    t.decimal "cstorg_ltl", precision: 22, scale: 6
    t.decimal "cst_btl", precision: 22, scale: 6
    t.decimal "cst_ltl", precision: 22, scale: 6
    t.decimal "amtzd_btl", precision: 22, scale: 6
    t.decimal "amtzd_ltl", precision: 22, scale: 6
    t.decimal "accrued_btl", precision: 22, scale: 6
    t.decimal "accrued_ltl", precision: 22, scale: 6
    t.decimal "market_value_btl", precision: 22, scale: 6
    t.decimal "market_value_ltl", precision: 22, scale: 6
    t.decimal "unrealized_gnls_btl", precision: 22, scale: 6
    t.decimal "unrealized_gnls_ltl", precision: 22, scale: 6
    t.decimal "market_price_bam", precision: 22, scale: 6
    t.decimal "market_price_lam", precision: 22, scale: 6
    t.decimal "market_price_eam", precision: 22, scale: 6
    t.decimal "current_xchart", precision: 22, scale: 6
    t.string "current_exch_rate_src", limit: 32
    t.string "fas_price_src", limit: 32
    t.string "market_price_currency", limit: 3
    t.string "market_price_eur", limit: 3
    t.string "market_value_code", limit: 32
    t.decimal "day_61_price", precision: 22, scale: 6
    t.decimal "day_61_day", precision: 22, scale: 6
    t.decimal "day_61_yield", precision: 22, scale: 6
    t.string "filler", limit: 128
    t.string "brkr_fins", limit: 32
    t.string "sw_closing_fx", limit: 32
    t.string "ssb_trade_id", limit: 32
    t.string "incm_currency", limit: 3
    t.string "fvm_code", limit: 32
    t.decimal "weight", precision: 18, scale: 10
    t.string "source_name", limit: 32
    t.boolean "redundant", default: false, null: false
    t.index ["etfg_date"], name: "date_idx_ssc"
  end

  create_table "ssc_pos_template", id: false, force: :cascade do |t|
    t.text "fund_type"
    t.text "fund_id"
    t.text "base_country"
    t.text "base_currency"
    t.text "calendar_date"
    t.text "asset_id"
    t.text "alt_asset_id_type1"
    t.text "alt_asset_id1"
    t.text "alt_asset_id_type2"
    t.text "alt_asset_id2"
    t.text "dtc_cusip"
    t.text "ticker"
    t.text "issue_long_name"
    t.text "invest_ind"
    t.text "asset_group"
    t.text "position_type"
    t.text "investment_type"
    t.text "state_code"
    t.text "incorporated_country"
    t.text "issued_country"
    t.text "trade_country"
    t.text "nratax_country"
    t.text "issue_date"
    t.text "maturity_date"
    t.text "days_to_maturity"
    t.text "original_coupon_rate"
    t.text "pos_int_rate"
    t.text "var_rate_change_date"
    t.text "var_rate_frequency"
    t.text "moody_rating"
    t.text "snp_rating"
    t.text "major_industry"
    t.text "minor_industry"
    t.text "pool_type"
    t.text "lot_account_num"
    t.text "repo_num"
    t.text "total_lots"
    t.text "trade_date"
    t.text "settlement_date"
    t.text "issue_class"
    t.text "report_class"
    t.text "call_put_ind"
    t.text "orig_strike_price"
    t.text "curr_strike_price"
    t.text "share_par_qty"
    t.text "contracts_qty"
    t.text "org_face_pos_qty"
    t.text "untcst_btl"
    t.text "untcst_ltl"
    t.text "cstorg_btl"
    t.text "cstorg_ltl"
    t.text "cst_btl"
    t.text "cst_ltl"
    t.text "amtzd_btl"
    t.text "amtzd_ltl"
    t.text "accrued_btl"
    t.text "accrued_ltl"
    t.text "market_value_btl"
    t.text "market_value_ltl"
    t.text "unrealized_gnls_btl"
    t.text "unrealized_gnls_ltl"
    t.text "market_price_bam"
    t.text "market_price_lam"
    t.text "market_price_eam"
    t.text "current_xchart"
    t.text "current_exch_rate_src"
    t.text "fas_price_src"
    t.text "market_price_currency"
    t.text "market_price_eur"
    t.text "market_value_code"
    t.text "day_61_price"
    t.text "day_61_day"
    t.text "day_61_yield"
    t.text "filler"
    t.text "brkr_fins"
    t.text "sw_closing_fx"
    t.text "ssb_trade_id"
    t.text "incm_currency"
    t.text "fvm_code"
  end

  create_table "ssc_tradeday", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.string "basket_code", limit: 32
    t.string "basket_name", limit: 128
    t.string "cusip", limit: 9
    t.string "ticker", limit: 32
    t.decimal "nav_per_shr", precision: 22, scale: 6
    t.decimal "nav_per_cu", precision: 22, scale: 6
    t.decimal "income_per_shr", precision: 22, scale: 6
    t.decimal "income_per_cu", precision: 22, scale: 6
    t.decimal "balancing_cash", precision: 22, scale: 6
    t.decimal "actual_total_cash", precision: 22, scale: 6
    t.decimal "shrs_outstanding", precision: 22, scale: 6
    t.decimal "total_net_assets", precision: 22, scale: 6
    t.decimal "income_dist", precision: 22, scale: 6
    t.decimal "st_cap_dist", precision: 22, scale: 6
    t.decimal "lt_cap_dist", precision: 22, scale: 6
    t.decimal "estimated_total_cash", precision: 22, scale: 6
    t.decimal "estimated_cil", precision: 22, scale: 6
    t.decimal "estimated_interest", precision: 22, scale: 6
    t.decimal "actual_cil", precision: 22, scale: 6
    t.decimal "actual_interest", precision: 22, scale: 6
    t.decimal "estimated_cash_div", precision: 22, scale: 6
    t.decimal "estimated_expense", precision: 22, scale: 6
    t.decimal "estimated_bkt_mkt", precision: 22, scale: 6
    t.decimal "actual_bkt_mkt", precision: 22, scale: 6
    t.decimal "actual_cash", precision: 22, scale: 6
    t.decimal "estimated_cash", precision: 22, scale: 6
    t.decimal "td_shrs_outstanding", precision: 22, scale: 6
    t.decimal "td_total_net_assets", precision: 22, scale: 6
    t.date "as_of_date"
    t.string "source_name", limit: 32
  end

  create_table "ssc_tradeday_template", id: false, force: :cascade do |t|
    t.text "basket_code"
    t.text "basket_name"
    t.text "cusip"
    t.text "ticker"
    t.text "nav_per_shr"
    t.text "nav_per_cu"
    t.text "income_per_shr"
    t.text "income_per_cu"
    t.text "balancing_cash"
    t.text "actual_total_cash"
    t.text "shrs_outstanding"
    t.text "total_net_assets"
    t.text "income_dist"
    t.text "st_cap_dist"
    t.text "lt_cap_dist"
    t.text "estimated_total_cash"
    t.text "estimated_cil"
    t.text "estimated_interest"
    t.text "actual_cil"
    t.text "actual_interest"
    t.text "estimated_cash_div"
    t.text "estimated_expense"
    t.text "estimated_bkt_mkt"
    t.text "actual_bkt_mkt"
    t.text "actual_cash"
    t.text "estimated_cash"
    t.text "td_shrs_outstanding"
    t.text "td_total_net_assets"
    t.date "as_of_date"
  end

  create_table "staging_composites", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "pooled_instrument_id"
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.string "composite_description", limit: 128
    t.decimal "aum", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "share_value", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "open_price", precision: 22, scale: 6
    t.decimal "low_price", precision: 22, scale: 6
    t.decimal "high_price", precision: 22, scale: 6
    t.decimal "close_price", precision: 22, scale: 6
    t.decimal "daily_return", precision: 22, scale: 6
    t.decimal "bid_ask_spread", precision: 22, scale: 6
    t.decimal "avg_bid_size", precision: 22, scale: 6
    t.decimal "avg_ask_size", precision: 22, scale: 6
    t.decimal "avg_midpoint", precision: 22, scale: 6
    t.decimal "basket_estimated_cash", precision: 22, scale: 6
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
    t.string "related_index_symbol", limit: 16
    t.decimal "net_expenses", precision: 22, scale: 6
    t.decimal "expense_ratio", precision: 22, scale: 6
    t.decimal "total_expenses", precision: 22, scale: 6
    t.decimal "other_expenses", precision: 22, scale: 6
    t.string "listing_exchange", limit: 64
    t.string "asset_class", limit: 28
    t.string "development_class", limit: 32
    t.string "focus", limit: 28
    t.string "lead_market_maker", limit: 128
    t.string "region", limit: 28
    t.decimal "levered_amount", precision: 22, scale: 6
    t.date "maturity_date"
    t.string "exposure_country", limit: 64
    t.string "selection_criteria", limit: 32
    t.string "weighting_scheme", limit: 32
    t.string "administrator", limit: 128
    t.string "advisor", limit: 128
    t.string "distributor", limit: 128
    t.decimal "fee_waivers", precision: 22, scale: 6
    t.string "fiscal_year_end", limit: 16
    t.string "futures_commission_merchant", limit: 128
    t.string "subadvisor", limit: 128
    t.string "tax_classification", limit: 128
    t.string "transfer_agent", limit: 50
    t.string "trustee", limit: 128
    t.decimal "creation_fee", precision: 22, scale: 6
    t.decimal "creation_unit_size", precision: 22, scale: 6
    t.string "custodian", limit: 128
    t.string "distribution_frequency", limit: 32
    t.decimal "management_fee", precision: 22, scale: 6
    t.string "portfolio_manager", limit: 128
    t.string "primary_benchmark"
    t.boolean "match", default: false, null: false
    t.boolean "exclude_from_ts", default: false, null: false
    t.index ["as_of_date", "datasource_id"], name: "index_staging_composites_on_as_of_date_and_datasource_id"
    t.index ["composite_ticker", "exchange_country"], name: "ticker_country_composites"
    t.index ["composite_ticker"], name: "index_staging_composites_on_composite_ticker"
    t.index ["etfg_date", "datasource_id"], name: "index_staging_composites_on_etfg_date_and_datasource_id"
    t.index ["figi"], name: "index_staging_composites_on_figi"
    t.index ["pooled_instrument_id"], name: "index_staging_composites_on_pooled_instrument_id"
  end

  create_table "staging_composites_092118", id: false, force: :cascade do |t|
    t.bigint "id"
    t.date "etfg_date"
    t.date "as_of_date"
    t.integer "datasource_id", limit: 2
    t.bigint "pooled_instrument_id"
    t.string "composite_ticker", limit: 32
    t.string "composite_name", limit: 128
    t.string "composite_description", limit: 128
    t.decimal "aum", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "share_value", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "open_price", precision: 22, scale: 6
    t.decimal "low_price", precision: 22, scale: 6
    t.decimal "high_price", precision: 22, scale: 6
    t.decimal "close_price", precision: 22, scale: 6
    t.decimal "daily_return", precision: 22, scale: 6
    t.decimal "bid_ask_spread", precision: 22, scale: 6
    t.decimal "avg_bid_size", precision: 22, scale: 6
    t.decimal "avg_ask_size", precision: 22, scale: 6
    t.decimal "avg_midpoint", precision: 22, scale: 6
    t.decimal "basket_estimated_cash", precision: 22, scale: 6
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
    t.decimal "net_expenses", precision: 22, scale: 6
    t.decimal "expense_ratio", precision: 22, scale: 6
    t.decimal "total_expenses", precision: 22, scale: 6
    t.decimal "other_expenses", precision: 22, scale: 6
    t.string "listing_exchange", limit: 64
    t.string "asset_class", limit: 28
    t.string "development_class", limit: 32
    t.string "focus", limit: 28
    t.string "lead_market_maker", limit: 128
    t.string "region", limit: 28
    t.decimal "levered_amount", precision: 22, scale: 6
    t.date "maturity_date"
    t.string "exposure_country", limit: 64
    t.string "selection_criteria", limit: 32
    t.string "weighting_scheme", limit: 32
    t.string "administrator", limit: 128
    t.string "advisor", limit: 128
    t.string "distributor", limit: 128
    t.decimal "fee_waivers", precision: 22, scale: 6
    t.string "fiscal_year_end", limit: 16
    t.string "futures_commission_merchant", limit: 128
    t.string "subadvisor", limit: 128
    t.string "tax_classification", limit: 128
    t.string "transfer_agent", limit: 50
    t.string "trustee", limit: 128
    t.decimal "creation_fee", precision: 22, scale: 6
    t.decimal "creation_unit_size", precision: 22, scale: 6
    t.string "custodian", limit: 128
    t.string "distribution_frequency", limit: 32
    t.decimal "management_fee", precision: 22, scale: 6
    t.string "portfolio_manager", limit: 128
    t.string "primary_benchmark"
    t.boolean "match"
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
    t.decimal "weight", precision: 18, scale: 10
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "notional_value", precision: 22, scale: 6
    t.decimal "total_shares_held", precision: 22, scale: 6
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
    t.string "disposition", limit: 32
    t.text "trace"
    t.boolean "exclude_from_ts", default: false, null: false
    t.decimal "coupon", precision: 22, scale: 6
    t.date "maturity_date"
    t.integer "segment", limit: 2
    t.index ["as_of_date", "datasource_id"], name: "index_staging_constituents_on_as_of_date_and_datasource_id"
    t.index ["composite_ticker", "exchange_country"], name: "ticker_country_constituents"
    t.index ["composite_ticker"], name: "index_staging_constituents_on_composite_ticker"
    t.index ["etfg_date", "datasource_id", "instrument_id"], name: "index_on_date_source_instrument"
    t.index ["etfg_date", "datasource_id", "instrument_id"], name: "staging_date_source_instrument"
    t.index ["etfg_date", "datasource_id"], name: "index_staging_constituents_on_etfg_date_and_datasource_id"
    t.index ["etfg_date"], name: "index_staging_constituents_on_etfg_date"
    t.index ["figi"], name: "index_staging_constituents_on_figi"
    t.index ["instrument_id"], name: "index_staging_constituents_on_instrument_id"
  end

  create_table "staging_constituents_092118", id: false, force: :cascade do |t|
    t.bigint "id"
    t.date "etfg_date"
    t.date "as_of_date"
    t.integer "datasource_id"
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
    t.boolean "match"
  end

  create_table "staging_industries", force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.integer "datasource_id"
    t.string "composite_ticker", limit: 32, null: false
    t.string "country", limit: 64, default: "US", null: false
    t.decimal "avg_daily_trading_volume", precision: 22, scale: 6
    t.decimal "call_volume", precision: 22, scale: 6
    t.decimal "discount_premium", precision: 22, scale: 6
    t.decimal "num_holdings", precision: 22, scale: 6
    t.decimal "options_volume", precision: 22, scale: 6
    t.decimal "put_call_ratio", precision: 22, scale: 6
    t.decimal "put_volume", precision: 22, scale: 6
    t.decimal "short_interest", precision: 22, scale: 6
    t.decimal "bid_ask_spread", precision: 22, scale: 6
    t.decimal "open_price", precision: 22, scale: 6
    t.decimal "high_price", precision: 22, scale: 6
    t.decimal "low_price", precision: 22, scale: 6
    t.decimal "close_price", precision: 22, scale: 6
    t.integer "pooled_instrument_id"
    t.boolean "match", default: false, null: false
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "aum", precision: 22, scale: 6
    t.boolean "exclude_from_ts", default: false, null: false
    t.index ["datasource_id", "etfg_date"], name: "index_staging_industries_on_datasource_id_and_etfg_date"
    t.index ["datasource_id"], name: "index_staging_industries_on_datasource_id"
    t.index ["etfg_date"], name: "index_staging_industries_on_etfg_date"
    t.index ["pooled_instrument_id"], name: "index_staging_industries_on_pooled_instrument_id"
  end

  create_table "staging_instrument_exceptions", force: :cascade do |t|
    t.integer "datasource_id", limit: 2, null: false
    t.bigint "instrument_id", null: false
    t.string "name_in_datasource", limit: 128, null: false
    t.date "etfg_date", null: false
    t.string "figi", limit: 12
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.string "cusip", limit: 9
    t.string "composite_ticker", limit: 32
    t.bigint "pooled_instrument_id"
    t.text "trace"
    t.index ["datasource_id"], name: "index_staging_instrument_exceptions_on_datasource_id"
    t.index ["etfg_date"], name: "index_staging_instrument_exceptions_on_etfg_date"
    t.index ["instrument_id"], name: "index_staging_instrument_exceptions_on_instrument_id"
  end

  create_table "ubs_etracs", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.string "product_name", limit: 128
    t.string "exchange_trading_symbol", limit: 32
    t.string "intraday_indicative_value_symbol_index", limit: 32
    t.decimal "intraday_indicative_value", precision: 22, scale: 6
    t.string "shares_outstanding_symbol_index", limit: 32
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.string "source_field", limit: 32
    t.date "as_of_date"
  end

  create_table "ubs_nav_template", id: false, force: :cascade do |t|
    t.text "product_name"
    t.text "exchange_trading_symbol"
    t.text "intraday_indicative_value_symbol_index"
    t.text "intraday_indicative_value"
    t.text "shares_outstanding_symbol_index"
    t.text "shares_outstanding"
    t.text "market_value"
    t.text "source_field"
    t.text "as_of_date"
  end

  create_table "usbank_nav", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "fund_name"
    t.text "fund_ticker"
    t.text "cusip"
    t.decimal "shares_outstanding", precision: 18, scale: 6
    t.decimal "nav", precision: 18, scale: 6
    t.decimal "nav_change_dollars", precision: 18, scale: 6
    t.decimal "nav_change_percentage", precision: 18, scale: 6
    t.decimal "market_price", precision: 18, scale: 6
    t.decimal "market_price_change_dollars", precision: 18, scale: 6
    t.decimal "market_price_change_percentage", precision: 18, scale: 6
    t.decimal "premium_discount", precision: 18, scale: 6
    t.date "rate_date"
  end

  create_table "usbank_nav_template", id: false, force: :cascade do |t|
    t.text "fund_name"
    t.text "fund_ticker"
    t.text "cusip"
    t.text "shares_outstanding"
    t.text "nav"
    t.text "nav_change_dollars"
    t.text "nav_change_percentage"
    t.text "market_price"
    t.text "market_price_change_dollars"
    t.text "market_price_change_percentage"
    t.text "premium_discount"
    t.text "rate_date"
  end

  create_table "usbank_pcf", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.text "fundticker"
    t.text "entityname"
    t.text "familyname"
    t.text "effectivedate"
    t.text "securityticker"
    t.text "securityid"
    t.text "securityalias"
    t.text "securityname"
    t.decimal "weight", precision: 22, scale: 6
    t.decimal "basketmarketvalue", precision: 22, scale: 6
    t.decimal "price", precision: 22, scale: 6
    t.decimal "shares", precision: 22, scale: 6
    t.decimal "securitymarketvalue", precision: 22, scale: 6
    t.text "corporateactionapplied"
    t.text "cilflag"
    t.text "basketid"
    t.decimal "nav", precision: 22, scale: 6
    t.decimal "estimatedcash", precision: 22, scale: 6
    t.decimal "actualcashamount", precision: 22, scale: 6
    t.decimal "sharesoutstanding", precision: 22, scale: 6
    t.decimal "currentxrate", precision: 22, scale: 6
  end

  create_table "usbank_pcf_template", id: false, force: :cascade do |t|
    t.text "fundticker"
    t.text "entityname"
    t.text "familyname"
    t.text "effectivedate"
    t.text "securityticker"
    t.text "securityid"
    t.text "securityalias"
    t.text "securityname"
    t.text "weight"
    t.text "basketmarketvalue"
    t.text "price"
    t.text "shares"
    t.text "securitymarketvalue"
    t.text "corporateactionapplied"
    t.text "cilflag"
    t.text "basketid"
    t.text "nav"
    t.text "estimatedcash"
    t.text "actualcashamount"
    t.text "sharesoutstanding"
    t.text "currentxrate"
  end

  create_table "usbank_total", force: :cascade do |t|
    t.date "etfg_date"
    t.date "as_of_date"
    t.text "fund_id"
    t.text "fund_name"
    t.text "fund_ticker"
    t.text "sub_account"
    t.text "security_id"
    t.text "security_id_type"
    t.text "sec_description"
    t.text "currency"
    t.text "long_short_ind"
    t.decimal "units", precision: 18, scale: 6
    t.decimal "price", precision: 18, scale: 6
    t.decimal "market_value_base", precision: 18, scale: 6
    t.decimal "total_cost", precision: 18, scale: 6
    t.text "ticker_symbol"
    t.decimal "interest_rate", precision: 18, scale: 6
    t.date "mat_date"
    t.text "country"
    t.text "state"
    t.text "income_prod_ind"
    t.text "pool_num"
    t.text "call_date"
    t.text "next_call_price"
    t.text "sic_code"
    t.text "naic_code"
    t.text "gics_sec_code"
    t.text "gics_ind_grp_code"
    t.text "gics_ind_code"
    t.text "gics_sub_ind_code"
    t.text "exchange_rate"
    t.text "moody_rating"
    t.text "snp_rating"
    t.text "r144a_restrict_flag"
    t.text "pool_type"
    t.text "asset_category"
    t.text "issue_collateral"
    t.text "issuer_type"
    t.text "strike_price"
    t.text "opt_expir_date"
    t.text "share_equiv_per_cntrct"
    t.text "issue_date"
    t.text "early_acq_date"
    t.text "late_acq_date"
    t.text "div_level_sic_code"
    t.text "series_num"
    t.text "usb_sec_type"
    t.text "unit_of_calc"
    t.text "pricing_symbol"
    t.text "prior_day_ex_rate"
    t.text "ex_rate_perc_change"
    t.decimal "prior_day_shares", precision: 18, scale: 6
    t.decimal "prior_day_price", precision: 18, scale: 6
    t.decimal "price_perc_change", precision: 18, scale: 6
    t.text "first_coupon"
    t.text "mbs_factor"
    t.text "underlying_cusip"
    t.decimal "total_assets", precision: 18, scale: 6
    t.decimal "total_net_assets", precision: 18, scale: 6
    t.text "sec_type_desc"
    t.decimal "amort_cost_base", precision: 18, scale: 6
    t.decimal "amort_cost_local", precision: 18, scale: 6
    t.decimal "accrued_inc_base", precision: 18, scale: 6
    t.decimal "accrued_inc_local", precision: 18, scale: 6
    t.text "field_01"
    t.text "field_02"
    t.text "field_03"
    t.text "field_04"
    t.text "field_05"
    t.text "field_06"
    t.text "field_07"
    t.text "field_08"
    t.text "field_09"
    t.text "field_10"
    t.decimal "weight", precision: 18, scale: 10
  end

  create_table "usbank_total_template", id: false, force: :cascade do |t|
    t.text "as_of_date"
    t.text "fund_id"
    t.text "fund_name"
    t.text "fund_ticker"
    t.text "sub_account"
    t.text "security_id"
    t.text "security_id_type"
    t.text "sec_description"
    t.text "currency"
    t.text "long_short_ind"
    t.text "units"
    t.text "price"
    t.text "market_value_base"
    t.text "total_cost"
    t.text "ticker_symbol"
    t.text "interest_rate"
    t.text "mat_date"
    t.text "country"
    t.text "state"
    t.text "income_prod_ind"
    t.text "pool_num"
    t.text "call_date"
    t.text "next_call_price"
    t.text "sic_code"
    t.text "naic_code"
    t.text "gics_sec_code"
    t.text "gics_ind_grp_code"
    t.text "gics_ind_code"
    t.text "gics_sub_ind_code"
    t.text "exchange_rate"
    t.text "moody_rating"
    t.text "snp_rating"
    t.text "r144a_restrict_flag"
    t.text "pool_type"
    t.text "asset_category"
    t.text "issue_collateral"
    t.text "issuer_type"
    t.text "strike_price"
    t.text "opt_expir_date"
    t.text "share_equiv_per_cntrct"
    t.text "issue_date"
    t.text "early_acq_date"
    t.text "late_acq_date"
    t.text "div_level_sic_code"
    t.text "series_num"
    t.text "usb_sec_type"
    t.text "unit_of_calc"
    t.text "pricing_symbol"
    t.text "prior_day_ex_rate"
    t.text "ex_rate_perc_change"
    t.text "prior_day_shares"
    t.text "prior_day_price"
    t.text "price_perc_change"
    t.text "first_coupon"
    t.text "mbs_factor"
    t.text "underlying_cusip"
    t.text "total_assets"
    t.text "total_net_assets"
    t.text "sec_type_desc"
    t.text "amort_cost_base"
    t.text "amort_cost_local"
    t.text "accrued_inc_base"
    t.text "accrued_inc_local"
    t.text "field_01"
    t.text "field_02"
    t.text "field_03"
    t.text "field_04"
    t.text "field_05"
    t.text "field_06"
    t.text "field_07"
    t.text "field_08"
    t.text "field_09"
    t.text "field_10"
  end

  create_table "vanguard_baskets", id: false, force: :cascade do |t|
    t.date "etfg_date"
    t.string "fund_name", limit: 128
    t.string "fund_identifier", limit: 14
    t.string "fund_identifier_type", limit: 32
    t.string "domicile", limit: 32
    t.string "fund_ticker", limit: 32, null: false
    t.date "trade_date"
    t.decimal "unit_size", precision: 22, scale: 6
    t.decimal "shares_outstanding", precision: 22, scale: 6
    t.decimal "nav", precision: 22, scale: 6
    t.string "basket_identifier", limit: 14
    t.string "basket_identifier_type", limit: 32
    t.string "basket_usage", limit: 32
    t.decimal "fixed_fee_create", precision: 22, scale: 6
    t.decimal "fixed_fee_redeem", precision: 22, scale: 6
    t.decimal "tba_fee", precision: 22, scale: 6
    t.decimal "cash_in_lieu_fee", precision: 22, scale: 6
    t.decimal "standard_custom_fee", precision: 22, scale: 6
    t.decimal "actual_cash", precision: 22, scale: 6
    t.decimal "estimated_cash", precision: 22, scale: 6
    t.decimal "expense_ratio", precision: 22, scale: 6
    t.decimal "daily_create_unit_limit", precision: 22, scale: 6
    t.decimal "daily_create_redeem_unit", precision: 22, scale: 6
    t.string "base_currency", limit: 16
  end

  create_table "vanguard_factors", id: false, force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.string "composite_name", limit: 128, null: false
    t.string "fund_id", limit: 32
    t.string "asset_type", limit: 128
    t.string "constituent_ticker", limit: 64
    t.string "constituent_name", limit: 128
    t.string "isin", limit: 12
    t.decimal "weight", precision: 22, scale: 6
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "shares", precision: 22, scale: 6
  end

  create_table "vanguard_holdings", id: false, force: :cascade do |t|
    t.date "etfg_date", null: false
    t.date "as_of_date", null: false
    t.string "composite_ticker", limit: 32, null: false
    t.string "composite_name", limit: 128, null: false
    t.string "fund_id", limit: 32
    t.string "asset_type", limit: 128
    t.string "constituent_ticker", limit: 64
    t.string "constituent_name", limit: 128
    t.string "cusip", limit: 9
    t.string "sedol", limit: 7
    t.string "isin", limit: 12
    t.decimal "weight", precision: 22, scale: 6
    t.string "sector", limit: 64
    t.string "country", limit: 64
    t.string "depository_receipt", limit: 32
    t.decimal "market_value", precision: 22, scale: 6
    t.decimal "face_amount", precision: 22, scale: 6
    t.decimal "coupon_rate", precision: 22, scale: 6
    t.date "maturity_date"
    t.decimal "shares", precision: 22, scale: 6
  end

  create_table "velocity", id: false, force: :cascade do |t|
    t.date "etf_date"
    t.string "etf_ticker", limit: 32
    t.decimal "etf_value", precision: 22, scale: 6
    t.decimal "etf_shares", precision: 22, scale: 6
  end

  create_table "xignite_api_calls", id: false, force: :cascade do |t|
    t.string "cusip", limit: 9, null: false
    t.string "industry", limit: 64
    t.string "sector", limit: 128
    t.text "data"
    t.index ["cusip"], name: "index_xignite_api_calls_on_cusip", unique: true
  end

  create_table "xignite_industry_mappings", id: false, force: :cascade do |t|
    t.string "source", limit: 64, null: false
    t.string "dest", limit: 64, null: false
  end

  create_table "xignite_sector_mappings", id: false, force: :cascade do |t|
    t.string "source", limit: 64, null: false
    t.string "dest", limit: 64, null: false
  end

end
