# == Schema Information
#
# Table name: bny_lookups
#
#  fund_id         :string(32)       not null, primary key
#  account_name    :string(128)      not null
#  ticker          :string(32)       not null
#  effective_date  :date
#  expiration_date :date
#

class BnyLookup < FeedSchemaBase
  BnyLookup.record_timestamps = false
  BnyLookup.primary_key = :fund_id
  
  validates :fund_id, :ticker, :presence => true, :length => { :maximum => 32 }
  validates :account_name, :presence => true, :length => { :maximum => 128 }
end
