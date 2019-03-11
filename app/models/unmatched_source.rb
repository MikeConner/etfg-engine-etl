# == Schema Information
#
# Table name: unmatched_sources
#
#  etfg_date     :date
#  datasource_id :integer
#  composite     :boolean
#

class UnmatchedSource < ApplicationRecord
  belongs_to :datasource
  
  self.record_timestamps = false
end
