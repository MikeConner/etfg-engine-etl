# == Schema Information
#
# Table name: agf_lookups
#
#  ticker        :string(32)       not null, primary key
#  holdings_name :string(128)      not null
#  nav_name      :string(128)      not null
#

require 'rails_helper'

RSpec.describe AgfLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
