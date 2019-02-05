# == Schema Information
#
# Table name: asset_class_lookups
#
#  id            :bigint(8)        not null, primary key
#  security_type :string
#  asset_class   :string(128)
#

class AssetClassLookup < FeedSchemaBase
  AssetClassLookup.record_timestamps = false
end
