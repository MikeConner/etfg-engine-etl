# == Schema Information
#
# Table name: ssc_ca_lookups
#
#  code      :string(32)       not null, primary key
#  ticker    :string(32)       not null
#  fund_name :string(128)      not null
#

class SscCaLookup < FeedSchemaBase
  self.record_timestamps = false
  self.primary_key = :code

  validates_length_of :code, :ticker, :maximum => 32
  validates_length_of :fund_name, :maximum => 128
end
