# == Schema Information
#
# Table name: ssc_lookups
#
#  id         :bigint(8)        not null, primary key
#  fund_id    :string(4)
#  fund_name  :string(128)
#  ticker     :string(32)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe SscLookup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
