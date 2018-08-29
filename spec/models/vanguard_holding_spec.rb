# == Schema Information
#
# Table name: vanguard_holdings
#
#  etfg_date          :date             not null
#  as_of_date         :date             not null
#  composite_ticker   :string(32)       not null
#  composite_name     :string(128)      not null
#  fund_id            :string(32)
#  asset_type         :string(128)
#  constituent_ticker :string(64)
#  constituent_name   :string(128)
#  cusip              :string(9)
#  sedol              :string(7)
#  isin               :string(12)
#  weight             :decimal(22, 6)
#  sector             :string(64)
#  country            :string(64)
#  depository_receipt :string(32)
#  market_value       :decimal(22, 6)
#  face_amount        :decimal(22, 6)
#  coupon_rate        :decimal(22, 6)
#  maturity_date      :date
#  shares             :decimal(22, 6)
#

require 'rails_helper'

RSpec.describe VanguardHolding, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
