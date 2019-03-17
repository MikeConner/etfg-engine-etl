# == Schema Information
#
# Table name: ts_industries
#
#  id                          :bigint(8)        not null, primary key
#  etfg_date                   :date             not null
#  composite_ticker            :string(32)
#  issuer                      :string(64)
#  description                 :string(128)
#  inception_date              :date
#  primary_benchmark           :string
#  tax_classification          :string(128)
#  is_etn                      :boolean
#  aum                         :decimal(22, 6)
#  avg_daily_trading_volume    :decimal(22, 6)
#  asset_class                 :string(28)
#  category                    :string(28)
#  focus                       :string(28)
#  development_class           :string(32)
#  region                      :string(28)
#  is_levered                  :boolean
#  levered_amount              :decimal(22, 6)
#  is_active                   :boolean
#  administrator               :string(128)
#  advisor                     :string(128)
#  custodian                   :string(128)
#  distributor                 :string(128)
#  portfolio_manager           :string
#  subadvisor                  :string(128)
#  transfer_agent              :string(50)
#  trustee                     :string(128)
#  futures_commission_merchant :string(128)
#  fiscal_year_end             :string(16)
#  distribution_frequency      :string(32)
#  listing_exchange            :string(64)
#  creation_unit_size          :decimal(22, 6)
#  creation_fee                :decimal(22, 6)
#  geographic_exposure         :text
#  currency_exposure           :text
#  sector_exposure             :text
#  industry_group_exposure     :text
#  industry_exposure           :text
#  subindustry_exposure        :text
#  coupon_exposure             :text
#  maturity_exposure           :text
#  options_available           :boolean
#  options_volume              :decimal(22, 6)
#  short_interest              :decimal(22, 6)
#  put_call_ratio              :decimal(18, 6)
#  num_holdings                :decimal(18, 6)
#  discount_premium            :decimal(18, 6)
#  bid_ask_spread              :decimal(18, 6)
#  put_volume                  :decimal(18, 6)
#  call_volume                 :decimal(18, 6)
#  management_fee              :decimal(18, 6)
#  other_expenses              :decimal(18, 6)
#  total_expenses              :decimal(18, 6)
#  fee_waivers                 :decimal(18, 6)
#  net_expenses                :decimal(18, 6)
#  lead_market_maker           :string(128)
#  pooled_instrument_id        :bigint(8)        not null
#  output_region               :string(2)
#

class TsIndustry < ApplicationRecord
  # This is in the feed schema!
  TsIndustry.record_timestamps = false
end
