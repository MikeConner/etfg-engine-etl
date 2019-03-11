# == Schema Information
#
# Table name: ts_exposures
#
#  id                   :bigint(8)        not null
#  etfg_date            :date             not null
#  pooled_instrument_id :bigint(8)        not null
#  exposure_type        :string(64)       not null
#  category             :string(64)       not null
#  exposure_value       :decimal(22, 6)   not null
#  region               :string(2)
#

class TsExposure < ApplicationRecord
end
