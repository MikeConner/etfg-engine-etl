# == Schema Information
#
# Table name: bny_lookups
#
#  fund_id      :string(32)       not null, primary key
#  account_name :string(128)      not null
#  ticker       :string(32)       not null
#

require 'rails_helper'

RSpec.describe BnyLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
