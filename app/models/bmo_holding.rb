# == Schema Information
#
# Table name: bmo_holdings
#
#  etfg_date           :date             not null
#  ticker              :string(32)       not null
#  instrument_type     :string(64)       not null
#  name                :string(128)
#  sedol               :string(7)
#  cusip               :string(9)
#  security_id         :string(64)
#  quantity_par_amount :decimal(22, 6)
#  as_of_date          :date
#

class BmoHolding < FeedSchemaBase
  # This is in the feed schema!
  BmoHolding.record_timestamps = false
end
