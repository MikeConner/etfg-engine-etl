# == Schema Information
#
# Table name: vanguard_factors
#
#  etfg_date          :date             not null
#  as_of_date         :date             not null
#  composite_ticker   :string(32)       not null
#  composite_name     :string(128)      not null
#  fund_id            :string(32)
#  asset_type         :string(128)
#  constituent_ticker :string(64)
#  constituent_name   :string(128)
#  isin               :string(12)
#  weight             :decimal(22, 6)
#  market_value       :decimal(22, 6)
#  shares             :decimal(22, 6)
#

class VanguardFactor < FeedSchemaBase
  # This is in the feed schema!
  VanguardFactor.record_timestamps = false
end
