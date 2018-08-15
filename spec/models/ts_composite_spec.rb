# == Schema Information
#
# Table name: ts_composites
#
#  id                    :bigint(8)        not null, primary key
#  etfg_date             :date             not null
#  datasource_id         :integer          not null
#  pooled_instrument_id  :bigint(8)
#  composite_ticker      :string(32)
#  composite_name        :string(128)
#  aum                   :decimal(18, 6)
#  shares_outstanding    :decimal(18, 6)
#  share_value           :decimal(18, 6)
#  nav                   :decimal(18, 6)
#  open_price            :decimal(18, 6)
#  low_price             :decimal(18, 6)
#  high_price            :decimal(18, 6)
#  close_price           :decimal(18, 6)
#  daily_return          :decimal(18, 6)
#  bid_ask_spread        :decimal(18, 6)
#  avg_bid_size          :decimal(18, 6)
#  avg_ask_size          :decimal(18, 6)
#  avg_midpoint          :decimal(18, 6)
#  basket_estimated_cash :decimal(18, 6)
#  publish               :boolean          default(FALSE), not null
#

RSpec.describe 'TsComposite', type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
