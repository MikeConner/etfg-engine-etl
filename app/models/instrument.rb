# == Schema Information
#
# Table name: instruments
#
#  id                   :bigint(8)        not null, primary key
#  issuer_id            :integer
#  issuer               :string(32)
#  ticker               :string(64)
#  name_variants        :text             not null
#  effective_date       :date
#  expiration_date      :date
#  figi                 :string(12)       not null
#  is_exchange_figi     :boolean          default(FALSE), not null
#  sedol                :string(7)
#  isin                 :string(12)
#  cusip                :string(9)
#  exchange_country     :string(64)
#  currency             :string(16)
#  exchange             :string(64)
#  market_sector        :string(128)
#  security_type        :string(128)
#  sector               :string(64)
#  industry             :string(64)
#  master_guid          :string(36)
#  industry_group       :string(128)
#  subindustry          :string(128)
#  rating               :string(32)
#  approved             :boolean          default(FALSE), not null
#  is_valid             :boolean          default(FALSE), not null
#  default_instrument   :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  standard_name        :string(128)
#  pooled_instrument_id :bigint(8)
#  instrument_id        :bigint(8)
#  secid                :string(12)
#  datasource_id        :integer
#  notes                :text
#

class Instrument < ApplicationRecord
  belongs_to :pooled_instrument, :optional => true
  
  has_many :instrument_exceptions, :dependent => :destroy
  
  scope :placeholders, -> { where("figi LIKE 'Unk%'") }
end
