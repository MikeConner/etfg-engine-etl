# == Schema Information
#
# Table name: bmo_basket_constituents
#
#  id                  :bigint(8)        not null, primary key
#  etfg_date           :date             not null
#  composite_ticker    :string(32)       not null
#  ticker              :string(64)
#  constituent_ticker  :string(64)
#  constituent_name    :string(128)
#  constituent_country :string(32)
#  price               :decimal(18, 6)
#  shares_per_basket   :decimal(18, 6)
#  number_shares       :decimal(18, 6)
#  sedol               :string(7)
#

require 'rails_helper'

RSpec.describe BmoBasketConstituent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
