# == Schema Information
#
# Table name: ssc_ca_lookups
#
#  code      :string(32)       not null, primary key
#  ticker    :string(32)       not null
#  fund_name :string(128)      not null
#

require 'rails_helper'

RSpec.describe SscCaLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
