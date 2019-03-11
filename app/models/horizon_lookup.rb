# == Schema Information
#
# Table name: horizon_lookups
#
#  account     :string(32)       not null, primary key
#  fund_ticker :string(32)       not null
#  fund_name   :string(128)      not null
#

class HorizonLookup < FeedSchemaBase
  self.record_timestamps = false
  self.primary_key = :account
  
  validates_length_of :fund_name, :maximum => 128
  validates_length_of :fund_ticker, :account, :maximum => 32
end
