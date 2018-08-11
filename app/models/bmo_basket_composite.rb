# == Schema Information
#
# Table name: bmo_basket_composites
#
#  id                :bigint(8)        not null, primary key
#  etfg_date         :date             not null
#  composite_ticker  :string(32)       not null
#  account_number    :string(32)
#  composite_name    :string(128)
#  units_outstanding :decimal(18, 6)
#  nav               :decimal(18, 6)
#  projected_cash    :decimal(18, 6)
#  dist_price_adj    :decimal(18, 6)
#  fx_rate           :decimal(18, 6)
#  mer_expense_ratio :decimal(18, 6)
#  prescribed_units  :decimal(18, 6)
#  caf_pct           :decimal(18, 6)
#

class BmoBasketComposite < FeedSchemaBase
  # This is in the feed schema!
  BmoHolding.record_timestamps = false
end
