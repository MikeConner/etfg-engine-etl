# == Schema Information
#
# Table name: staging_constituents
#
#  id                   :bigint(8)        not null, primary key
#  etfg_date            :date             not null
#  as_of_date           :date             not null
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
#  issuer_id            :integer
#  issuer               :string(32)
#  figi                 :string(12)
#  is_exchange_figi     :boolean
#  sedol                :string(7)
#  isin                 :string(12)
#  cusip                :string(9)
#  exchange_country     :string(64)
#  currency             :string(16)
#  exchange             :string(64)
#  market_sector        :string(128)
#  security_type        :string(128)
#  sector               :string(64)
#  industry             :string(64)
#  industry_group       :string(128)
#  subindustry          :string(128)
#  rating               :string(32)
#  match                :boolean          default(FALSE), not null
#  disposition          :string(32)
#  trace                :text
#  exclude_from_ts      :boolean          default(FALSE), not null
#  coupon               :decimal(22, 6)
#  maturity_date        :date
#  segment              :integer
#  base_currency        :string(16)
#

require 'rails_helper'

RSpec.describe StagingConstituent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
