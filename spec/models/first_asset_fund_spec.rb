# == Schema Information
#
# Table name: first_asset_funds
#
#  ticker    :string(4)        not null, primary key
#  fund_name :string(128)
#  address   :string           not null
#

require 'rails_helper'

RSpec.describe FirstAssetFund, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
