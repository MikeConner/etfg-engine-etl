# == Schema Information
#
# Table name: ambiguous_instruments
#
#  id              :bigint(8)        not null, primary key
#  datasource_id   :integer          not null
#  file_date       :date             not null
#  datasource_line :bigint(8)        not null
#  instrument_list :text             not null
#  resolved_id     :bigint(8)
#

class AmbiguousInstrument < ApplicationRecord
  belongs_to :datasource
end
