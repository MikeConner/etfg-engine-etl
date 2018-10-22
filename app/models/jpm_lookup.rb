# == Schema Information
#
# Table name: jpm_lookups
#
#  id             :bigint(8)        not null, primary key
#  source         :string(16)       not null
#  account_number :string(32)       not null
#  account_name   :string(128)
#  ticker         :string(32)       not null
#

class JpmLookup < FeedSchemaBase
  JpmLookup.record_timestamps = false
  
  VALID_SOURCES = ['Flex', 'Pos', 'Prod', 'Profund']
  
  validates :source, :presence => true, :length => { :maximum => 16 }, :inclusion => { :in => VALID_SOURCES }
  validates :account_number, :ticker, :presence => true, :length => { :maximum => 32 }
end
