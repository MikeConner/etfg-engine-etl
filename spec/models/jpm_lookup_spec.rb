# == Schema Information
#
# Table name: jpm_lookups
#
#  id             :bigint(8)        not null, primary key
#  source         :string(16)       not null
#  account_number :string(32)       not null
#  account_name   :string(128)
#  ticker         :string(32)       not null
#

require 'rails_helper'

RSpec.describe JpmLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
