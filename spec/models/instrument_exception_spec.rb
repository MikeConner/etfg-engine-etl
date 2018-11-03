# == Schema Information
#
# Table name: instrument_exceptions
#
#  id                   :bigint(8)        not null, primary key
#  datasource_id        :integer          not null
#  instrument_id        :bigint(8)        not null
#  candidate_name       :string(128)      not null
#  standard_name        :string(128)      not null
#  composite_ticker     :string(32)
#  pooled_instrument_id :bigint(8)
#  figi                 :string(12)
#  sedol                :string(7)
#  isin                 :string(12)
#  cusip                :string(9)
#  start_date           :date
#  end_date             :date
#  skipped              :boolean          default(FALSE), not null
#  resolution           :string(16)
#  score                :integer
#

require 'rails_helper'

RSpec.describe InstrumentException, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
