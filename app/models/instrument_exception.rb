# == Schema Information
#
# Table name: instrument_exceptions
#
#  id                   :bigint(8)        not null
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
#  etfg_date            :date
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
  ACCEPT_AS_STANDARD = 'Accept Std'
  IGNORE = 'Ignore'
  EXCEPTION = 'Exception'
  CORP_ACTION = 'Action'
  
  scope :skipped, -> { where("skipped=#{ActiveRecord::Base.connection.quoted_true}") }
  scope :pending, -> { where(:resolution => nil) }
  scope :corporate, -> { where(:resolution => CORP_ACTION) }
  
  def hide?
    [EXCEPTION, CORP_ACTION].include?(self.resolution)
  end
end
