# == Schema Information
#
# Table name: staging_industries
#
#  id                       :bigint(8)        not null, primary key
#  etfg_date                :date             not null
#  as_of_date               :date             not null
#  datasource_id            :integer          not null
#  composite_ticker         :string(32)       not null
#  country                  :string(64)       default("US"), not null
#  avg_daily_trading_volume :decimal(22, 6)
#  call_volume              :decimal(22, 6)
#  discount_premium         :decimal(22, 6)
#  num_holdings             :decimal(22, 6)
#  options_volume           :decimal(22, 6)
#  put_call_ratio           :decimal(22, 6)
#  put_volume               :decimal(22, 6)
#  short_interest           :decimal(22, 6)
#  bid_ask_spread           :decimal(22, 6)
#  open_price               :decimal(22, 6)
#  high_price               :decimal(22, 6)
#  low_price                :decimal(22, 6)
#  close_price              :decimal(22, 6)
#  pooled_instrument_id     :integer
#  match                    :boolean          default(FALSE), not null
#  nav                      :decimal(22, 6)
#  aum                      :decimal(22, 6)
#  exclude_from_ts          :boolean          default(FALSE), not null
#

require 'rails_helper'

RSpec.describe StagingIndustry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
