# == Schema Information
#
# Table name: staging_instrument_exceptions
#
#  id                   :bigint(8)        not null, primary key
#  datasource_id        :integer          not null
#  instrument_id        :bigint(8)        not null
#  name_in_datasource   :string(128)      not null
#  etfg_date            :date             not null
#  figi                 :string(12)
#  sedol                :string(7)
#  isin                 :string(12)
#  cusip                :string(9)
#  composite_ticker     :string(32)
#  pooled_instrument_id :bigint(8)
#  trace                :text
#

require 'rails_helper'

RSpec.describe StagingInstrumentException, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
