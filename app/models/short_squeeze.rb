# == Schema Information
#
# Table name: short_squeezes
#
#  id                   :bigint(8)        not null, primary key
#  etfg_date            :date             not null
#  record_date          :date             not null
#  symbol               :string(32)       not null
#  company              :string(128)
#  total_short_interest :decimal(22, 6)
#  days_to_cover        :decimal(22, 6)
#  short_pct_of_float   :decimal(22, 6)
#  short_prior_mo       :decimal(22, 6)
#

class ShortSqueeze < FeedSchemaBase
  # This is in the feed schema!
  ShortSqueeze.record_timestamps = false
end
