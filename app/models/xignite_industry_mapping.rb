# == Schema Information
#
# Table name: xignite_industry_mappings
#
#  source :string(64)       not null, primary key
#  dest   :string(64)       not null
#

class XigniteIndustryMapping < FeedSchemaBase
  XigniteIndustryMapping.record_timestamps = false
  XigniteIndustryMapping.primary_key = :source
end
