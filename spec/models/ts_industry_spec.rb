# == Schema Information
#
# Table name: ts_industries
#
#  id                       :bigint(8)        not null, primary key
#  etfg_date                :date             not null
#  as_of_date               :date             not null
#  datasource_id            :integer          not null
#  avg_daily_trading_volume :decimal(18, 6)
#  call_volume              :decimal(18, 6)
#  discount_premium         :decimal(18, 6)
#  num_holdings             :decimal(18, 6)
#  options_volume           :decimal(18, 6)
#  put_call_ratio           :decimal(18, 6)
#  put_volume               :decimal(18, 6)
#  short_interest           :decimal(18, 6)
#  avg_bid_size             :decimal(18, 6)
#  avg_ask_size             :decimal(18, 6)
#  bid_ask_spread           :decimal(18, 6)
#  avg_midpoint             :decimal(18, 6)
#  open_price               :decimal(18, 6)
#  high_price               :decimal(18, 6)
#  low_price                :decimal(18, 6)
#  close_price              :decimal(18, 6)
#  daily_return             :decimal(18, 6)
#  basket_estimated_cash    :decimal(18, 6)
#  pooled_instrument_id     :bigint(8)
#

require 'rails_helper'

RSpec.describe TsIndustry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
