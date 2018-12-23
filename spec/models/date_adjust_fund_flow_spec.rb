# == Schema Information
#
# Table name: date_adjust_fund_flows
#
#  composite_ticker :string(32)       not null, primary key
#  effective_date   :date
#  expiration_date  :date
#  slug             :string
#  datasource_id    :integer
#

require 'rails_helper'

RSpec.describe DateAdjustFundFlow, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
