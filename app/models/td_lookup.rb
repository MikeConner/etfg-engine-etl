# == Schema Information
#
# Table name: td_lookups
#
#  ticker         :string(32)
#  account_number :string(32)       primary key
#

class TdLookup < FeedSchemaBase
  self.record_timestamps = false
  self.primary_key = :account_number

  validates_length_of :account_number, :ticker, :maximum => 32
end
