# == Schema Information
#
# Table name: bny_lookups
#
#  fund_id      :string(32)
#  account_name :string(128)
#  ticker       :string(32)
#

class BnyLookup < FeedSchemaBase
  BnyLookup.record_timestamps = false
end
