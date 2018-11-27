# == Schema Information
#
# Table name: xignite_sector_mappings
#
#  source :string(64)       not null, primary key
#  dest   :string(64)       not null
#

class XigniteSectorMapping < FeedSchemaBase
  XigniteSectorMapping.record_timestamps = false
  XigniteSectorMapping.primary_key = :source
end
