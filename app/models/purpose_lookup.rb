# == Schema Information
#
# Table name: purpose_lookups
#
#  account_number :string(32)       primary key
#  ticker         :string(32)
#

class PurposeLookup < FeedSchemaBase
  self.record_timestamps = false
  self.primary_key = :account_number

  validates_length_of :account_number, :maximum => 32
  validates_length_of :ticker, :ticker, :maximum => 32
end
