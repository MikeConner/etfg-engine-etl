# == Schema Information
#
# Table name: vanguard_baskets
#
#  etfg_date                :date
#  fund_name                :string(128)
#  fund_identifier          :string(14)
#  fund_identifier_type     :string(32)
#  domicile                 :string(32)
#  fund_ticker              :string(32)       not null
#  trade_date               :date
#  unit_size                :decimal(22, 6)
#  shares_outstanding       :decimal(22, 6)
#  nav                      :decimal(22, 6)
#  basket_identifier        :string(14)
#  basket_identifier_type   :string(32)
#  basket_usage             :string(32)
#  fixed_fee_create         :decimal(22, 6)
#  fixed_fee_redeem         :decimal(22, 6)
#  tba_fee                  :decimal(22, 6)
#  cash_in_lieu_fee         :decimal(22, 6)
#  standard_custom_fee      :decimal(22, 6)
#  actual_cash              :decimal(22, 6)
#  estimated_cash           :decimal(22, 6)
#  expense_ratio            :decimal(22, 6)
#  daily_create_unit_limit  :decimal(22, 6)
#  daily_create_redeem_unit :decimal(22, 6)
#  base_currency            :string(16)
#

class VanguardBasket < FeedSchemaBase
  # This is in the feed schema!
  VanguardBasket.record_timestamps = false
end
