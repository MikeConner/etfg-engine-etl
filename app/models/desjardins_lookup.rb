# == Schema Information
#
# Table name: desjardins_lookups
#
#  fund_code :string(32)       primary key
#  ticker    :string(32)
#

class DesjardinsLookup < FeedSchemaBase
  self.record_timestamps = false
  self.primary_key = :fund_code

  validates_length_of :fund_code, :ticker, :maximum => 32
end
