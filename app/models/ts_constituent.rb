# == Schema Information
#
# Table name: ts_constituents
#
#  id                   :bigint(8)        not null, primary key
#  etfg_date            :date             not null
#  datasource_id        :integer          not null
#  pooled_instrument_id :bigint(8)        not null
#  instrument_id        :bigint(8)        not null
#  composite_ticker     :string(32)
#  composite_name       :string(128)      not null
#  constituent_ticker   :string(64)
#  constituent_name     :string(128)      not null
#  weight               :decimal(18, 6)
#  market_value         :decimal(18, 6)
#  notional_value       :decimal(18, 6)
#  total_shares_held    :decimal(18, 6)
#  publish              :boolean          default(FALSE), not null
#

class TsConstituent < ApplicationRecord
end
