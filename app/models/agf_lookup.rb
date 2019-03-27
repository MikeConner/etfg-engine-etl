# == Schema Information
#
# Table name: agf_lookups
#
#  ticker      :string(32)       not null, primary key
#  fund_number :string(64)       not null
#

class AgfLookup < FeedSchemaBase
  self.primary_key = :ticker
  self.record_timestamps = false

  validates_length_of :ticker, :maximum => 32
  validates_length_of :fund_number, :maximum => 64
end
