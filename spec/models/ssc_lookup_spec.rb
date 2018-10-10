# == Schema Information
#
# Table name: ssc_lookups
#
#  fund_id         :string(4)
#  fund_name       :string(128)
#  ticker          :string(32)
#  effective_date  :date
#  expiration_date :date
#  fund_id_alias   :string(4)
#

require 'rails_helper'

RSpec.describe SscLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
