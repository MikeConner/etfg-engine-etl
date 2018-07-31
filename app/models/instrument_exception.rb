# == Schema Information
#
# Table name: instrument_exceptions
#
#  id                 :bigint(8)        not null, primary key
#  datasource_id      :integer          not null
#  file_date          :date             not null
#  instrument_id      :bigint(8)        not null
#  name_in_datasource :string(128)      not null
#  datasource_lines   :text             not null
#

class InstrumentException < ApplicationRecord
end
