# == Schema Information
#
# Table name: holidays
#
#  id          :bigint(8)        not null, primary key
#  country     :string(2)        default("US"), not null
#  market_day  :date             not null
#  is_open     :boolean          not null
#  description :string
#

require 'rails_helper'

RSpec.describe Holiday, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
