# == Schema Information
#
# Table name: agf_lookups
#
#  ticker        :string(32)       not null, primary key
#  holdings_name :string(128)      not null
#  nav_name      :string(128)      not null
#

class AgfLookup < FeedSchemaBase
  self.primary_key = :ticker
  AgfLookup.record_timestamps = false
end
