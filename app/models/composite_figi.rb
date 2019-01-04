# == Schema Information
#
# Table name: composite_figis
#
#  id             :bigint(8)        not null
#  figi           :string(12)       not null
#  composite_figi :string(12)       not null
#  created_at     :datetime         not null
#  ticker         :string(64)
#  name           :string(128)
#  security_type  :string(128)
#  market_sector  :string(128)
#  exchange_code  :string(32)
#  unique_id      :string(32)
#  description    :string
#  iso_country    :string(2)
#

class CompositeFigi < ApplicationRecord
end
