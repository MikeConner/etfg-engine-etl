# == Schema Information
#
# Table name: date_adjust_fund_flows
#
#  composite_ticker :string(32)       not null, primary key
#  effective_date   :date
#  expiration_date  :date
#  slug             :string
#

class DateAdjustFundFlow < ApplicationRecord
  extend FriendlyId
  friendly_id :composite_ticker, :use => :slugged
  
  DateAdjustFundFlow.record_timestamps = false
  DateAdjustFundFlow.primary_key = :composite_ticker
  
  validates_length_of :composite_ticker, :presence => true, :maximum => 32
end
