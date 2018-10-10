# == Schema Information
#
# Table name: ssc_lookups
#
#  fund_id         :string(4)
#  fund_name       :string(128)
#  ticker          :string(32)
#  effective_date  :date
#  expiration_date :date
#  fund_id_alias   :string(4)
#

class SscLookup < FeedSchemaBase
  SscLookup.record_timestamps = false
end
