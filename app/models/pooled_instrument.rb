# == Schema Information
#
# Table name: pooled_instruments
#
#  id                          :bigint(8)        not null, primary key
#  issuer_id                   :integer
#  instrument_id               :integer
#  issuer                      :string(64)
#  composite_ticker            :string(32)       not null
#  composite_name_variants     :text             not null
#  standard_composite_name     :string(128)      not null
#  composite_description       :string
#  effective_date              :date
#  expiration_date             :date
#  exchange_country            :string(64)       not null
#  is_index                    :boolean          default(FALSE), not null
#  is_active                   :boolean
#  is_etn                      :boolean
#  is_levered                  :boolean
#  is_inverse                  :boolean
#  has_derivatives             :boolean
#  options_available           :boolean
#  inception_date              :date
#  etp_structure_type          :string(50)
#  category                    :string(28)
#  related_index               :string(50)
#  related_index_symbol        :string(16)
#  related_index_name          :string(50)
#  net_expenses                :decimal(18, 6)
#  expense_ratio               :decimal(18, 6)
#  listing_exchange            :string(64)
#  asset_class                 :string(28)
#  development_class           :string(32)
#  focus                       :string(28)
#  lead_market_maker           :string(128)
#  region                      :string(28)
#  levered_amount              :decimal(18, 6)
#  maturity_date               :date
#  exposure_country            :string(64)
#  selection_criteria          :string(32)
#  weighting_scheme            :string(32)
#  administrator               :string(128)
#  advisor                     :string(128)
#  distributor                 :string(128)
#  fee_waivers                 :decimal(18, 6)
#  fiscal_year_end             :string(16)
#  futures_commission_merchant :string(128)
#  subadvisor                  :string(128)
#  tax_classification          :string(128)
#  transfer_agent              :string(50)
#  trustee                     :string(128)
#  creation_fee                :decimal(18, 6)
#  creation_unit_size          :decimal(18, 6)
#  custodian                   :string(128)
#  distribution_frequency      :string(32)
#  management_fee              :decimal(18, 6)
#  portfolio_manager           :string
#  primary_benchmark           :string
#  total_expenses              :decimal(18, 6)
#  other_expenses              :decimal(18, 6)
#  approved                    :boolean          default(FALSE), not null
#  pooled_instrument_id        :bigint(8)
#  created_at                  :datetime         not null
#  secid                       :string(12)
#  figi                        :string(12)
#  is_exchange_figi            :boolean          default(FALSE), not null
#  sedol                       :string(7)
#  isin                        :string(12)
#  cusip                       :string(9)
#  datasource_id               :integer
#  exclude_from_ts             :boolean          default(FALSE), not null
#

class PooledInstrument < ApplicationRecord
  belongs_to :datasource, :optional => true
  
  validates_length_of :composite_ticker, :distribution_frequency, :maximum => 32
  validates_length_of :issuer, :maximum => 64
end
