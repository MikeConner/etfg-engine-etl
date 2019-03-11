# == Schema Information
#
# Table name: horizon_lookups
#
#  account     :string(32)       not null, primary key
#  fund_ticker :string(32)       not null
#  fund_name   :string(128)      not null
#

require 'rails_helper'

RSpec.describe HorizonLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
