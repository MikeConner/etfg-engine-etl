# == Schema Information
#
# Table name: pooled_instrument_overwrites
#
#  id                    :bigint(8)        not null, primary key
#  instrument_id         :bigint(8)        not null
#  previous_composite_id :bigint(8)        not null
#  current_composite_id  :bigint(8)        not null
#  datasource_id         :integer          not null
#  file_date             :date             not null
#  datasource_line       :bigint(8)        not null
#

class PooledInstrumentOverwrite < ApplicationRecord
end
