# == Schema Information
#
# Table name: composite_country_overrides
#
#  id                :bigint(8)        not null, primary key
#  datasource_id     :bigint(8)        not null
#  composite_ticker  :string(32)       not null
#  composite_country :string(2)        not null
#

class CompositeCountryOverride < ApplicationRecord
  belongs_to :datasource
  
  validates_length_of :composite_ticker, :maximum => 32, :presence => true
  validates_length_of :composite_country, :is => 2
end
