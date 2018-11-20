# == Schema Information
#
# Table name: xignite_api_calls
#
#  cusip    :string(9)        not null, primary key
#  industry :string(64)
#  sector   :string(128)
#  data     :text
#

class XigniteApiCall < FeedSchemaBase
  # This is in the feed schema!
  XigniteApiCall.record_timestamps = false
  XigniteApiCall.primary_key = :cusip
end
