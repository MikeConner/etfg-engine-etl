# == Schema Information
#
# Table name: jpm_lookups
#
#  source         :string(16)
#  account_number :string(32)
#  account_name   :string(128)
#  ticker         :string(32)
#

class JpmLookup < FeedSchemaBase
  SscLookup.record_timestamps = false
end
