# == Schema Information
#
# Table name: ts_composites
#
#  id                        :bigint(8)        not null, primary key
#  etfg_date                 :date             not null
#  datasource_id             :integer          not null
#  pooled_instrument_id      :bigint(8)
#  composite_ticker          :string(32)
#  composite_name            :string(128)
#  aum                       :decimal(22, 6)
#  shares_outstanding        :decimal(22, 6)
#  share_value               :decimal(22, 6)
#  nav                       :decimal(22, 6)
#  open_price                :decimal(22, 6)
#  low_price                 :decimal(22, 6)
#  high_price                :decimal(22, 6)
#  close_price               :decimal(22, 6)
#  daily_return              :decimal(22, 6)
#  avg_bid_size              :decimal(22, 6)
#  avg_ask_size              :decimal(22, 6)
#  avg_midpoint              :decimal(22, 6)
#  basket_estimated_cash     :decimal(22, 6)
#  publish                   :boolean          default(FALSE), not null
#  as_of_date                :date             not null
#  factor                    :decimal(22, 6)   default(1.0)
#  factor_shares_outstanding :decimal(22, 6)
#  exchange_country          :string(64)
#

class TsComposite < ApplicationRecord
end
