# == Schema Information
#
# Table name: df_composite_identifiers
#
#  datasource_id  :integer          not null
#  ticker         :string(32)       not null
#  name           :string(128)
#  figi           :string(12)       not null
#  composite_figi :boolean          default(TRUE), not null
#  sedol          :string(7)
#  isin           :string(12)
#  cusip          :string(9)
#  secid          :string(12)
#

class DfCompositeIdentifier < FeedSchemaBase
  # This is in the feed schema!
  DfCompositeIdentifier.record_timestamps = false
end
