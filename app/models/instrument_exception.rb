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

class InstrumentException < ApplicationRecord
  belongs_to :datasource
  belongs_to :instrument
  belongs_to :pooled_instrument, :optional => true
 
  SKIP = 'Skip'
  ACCEPT = 'Accept'
  IGNORE = 'Ignore'
  EXCEPTION = 'Exception'
  CORP_ACTION = 'Action'
  
  scope :skipped, -> { where("skipped=#{ActiveRecord::Base.connection.quoted_true}") }
  scope :pending, -> { where("skipped=#{ActiveRecord::Base.connection.quoted_false} AND resolution IS NULL") }
  
  def hide?
    [EXCEPTION, CORP_ACTION].include?(self.resolution)
  end
end
