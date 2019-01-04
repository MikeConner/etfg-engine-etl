# == Schema Information
#
# Table name: pooled_instrument_exceptions
#
#  id                   :bigint(8)        not null
#  datasource_id        :integer          not null
#  file_date            :date             not null
#  pooled_instrument_id :bigint(8)        not null
#  name_in_datasource   :string(128)      not null
#  datasource_lines     :text             not null
#  skipped              :boolean          default(FALSE), not null
#

class PooledInstrumentException < ApplicationRecord
  belongs_to :pooled_instrument
  belongs_to :datasource
  
  scope :skipped, -> { where("skipped=#{ActiveRecord::Base.connection.quoted_true}") }
end
