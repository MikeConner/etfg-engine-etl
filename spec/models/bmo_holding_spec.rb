# == Schema Information
#
# Table name: bmo_holdings
#
#  etfg_date           :date             not null
#  composite_ticker    :string(32)       not null
#  constituent_ticker  :string(64)       not null
#  constituent_name    :string(128)
#  constituent_country :string(64)
#  instrument_type     :string(128)
#  security_id         :string(64)
#  total_shares_held   :decimal(18, 6)
#  sedol               :string(7)
#  cusip               :string(9)
#

require 'rails_helper'

RSpec.describe BmoHolding, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
