# == Schema Information
#
# Table name: vanguard_etfs
#
#  etfg_date            :date             not null
#  trade_date           :date             not null
#  ticker               :string(64)
#  isin                 :string(12)
#  sedol                :string(7)
#  cusip                :string(9)
#  description          :string(128)
#  basket_type          :string(32)
#  nav                  :decimal(22, 6)
#  status               :string(32)
#  creation_unit_shares :decimal(22, 6)
#  application_value    :decimal(22, 6)
#  sum_market_value     :decimal(22, 6)
#  actual_cash          :decimal(22, 6)
#  source_name          :string(32)
#

require 'rails_helper'

RSpec.describe VanguardEtf, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
