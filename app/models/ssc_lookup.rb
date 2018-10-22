# == Schema Information
#
# Table name: ssc_lookups
#
#  id              :bigint(8)        not null, primary key
#  fund_id         :string(4)        not null
#  fund_name       :string(128)
#  ticker          :string(32)       not null
#  effective_date  :date
#  expiration_date :date
#  fund_id_alias   :string(4)
#

class SscLookup < FeedSchemaBase
  SscLookup.record_timestamps = false
  
  validates :fund_id, :presence => true, :length => { :maximum => 4 }
  validates :fund_name, :length => { :maximum => 128 }, :allow_nil => true
  validates :ticker, :presence => true, :length => { :maximum => 32 }
  validates :fund_id_alias, :length => { :maximum => 4 }, :allow_nil => true
end
