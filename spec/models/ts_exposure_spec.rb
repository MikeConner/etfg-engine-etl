# == Schema Information
#
# Table name: ts_exposures
#
#  id                   :bigint(8)        not null, primary key
#  etfg_date            :date             not null
#  pooled_instrument_id :bigint(8)        not null
#  exposure_type        :string(64)       not null
#  category             :string(64)       not null
#  exposure_value       :decimal(22, 6)   not null
#  region               :string(2)
#

require 'rails_helper'

RSpec.describe TsExposure, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
