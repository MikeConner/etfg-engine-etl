# == Schema Information
#
# Table name: ts_constituents
#
#  id                   :bigint(8)        not null, primary key
#  etfg_date            :date             not null
#  datasource_id        :integer          not null
#  pooled_instrument_id :bigint(8)
#  instrument_id        :bigint(8)
#  composite_ticker     :string(32)
#  composite_name       :string(128)
#  constituent_ticker   :string(64)
#  constituent_name     :string(128)
#  weight               :decimal(18, 10)
#  market_value         :decimal(22, 6)
#  notional_value       :decimal(22, 6)
#  total_shares_held    :decimal(22, 6)
#  publish              :boolean          default(FALSE), not null
#  as_of_date           :date             not null
#  currency             :string(16)
#  coupon               :decimal(22, 6)
#  maturity_date        :date
#  coupon_range         :string(8)
#  years_to_maturity    :integer
#  maturity_range       :string(8)
#  base_currency        :string(16)
#  backfill_flag        :boolean          default(FALSE), not null
#  exchange_country     :string(64)
#  asset_class          :string(28)
#

class TsConstituent < ApplicationRecord
end
