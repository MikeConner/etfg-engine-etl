# == Schema Information
#
# Table name: holidays
#
#  market_day  :date             not null, primary key
#  is_open     :boolean          not null
#  description :string
#

require 'rails_helper'

RSpec.describe Holiday, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
