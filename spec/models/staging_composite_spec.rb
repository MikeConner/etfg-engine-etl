# == Schema Information
#
# Table name: staging_composites
#
#  id                          :bigint(8)        not null, primary key
#  etfg_date                   :date             not null
#  as_of_date                  :date             not null
#  datasource_id               :integer          not null
#  pooled_instrument_id        :bigint(8)
#  composite_ticker            :string(32)
#  composite_name              :string(128)
#  composite_description       :string(128)
#  aum                         :decimal(22, 6)
#  shares_outstanding          :decimal(22, 6)
#  share_value                 :decimal(22, 6)
#  nav                         :decimal(22, 6)
#  open_price                  :decimal(22, 6)
#  low_price                   :decimal(22, 6)
#  high_price                  :decimal(22, 6)
#  close_price                 :decimal(22, 6)
#  daily_return                :decimal(22, 6)
#  bid_ask_spread              :decimal(22, 6)
#  avg_bid_size                :decimal(22, 6)
#  avg_ask_size                :decimal(22, 6)
#  avg_midpoint                :decimal(22, 6)
#  issuer_id                   :integer
#  issuer                      :string(32)
#  figi                        :string(12)
#  is_exchange_figi            :boolean
#  sedol                       :string(7)
#  isin                        :string(12)
#  cusip                       :string(9)
#  exchange_country            :string(64)
#  currency                    :string(16)
#  exchange                    :string(64)
#  market_sector               :string(128)
#  security_type               :string(128)
#  sector                      :string(64)
#  industry                    :string(64)
#  industry_group              :string(128)
#  subindustry                 :string(128)
#  rating                      :string(32)
#  is_index                    :boolean
#  is_active                   :boolean
#  is_etn                      :boolean
#  is_levered                  :boolean
#  is_inverse                  :boolean
#  has_derivatives             :boolean
#  options_available           :boolean
#  inception_date              :date
#  etp_structure_type          :string(50)
#  category                    :string(28)
#  related_index_symbol        :string(16)
#  net_expenses                :decimal(22, 6)
#  expense_ratio               :decimal(22, 6)
#  total_expenses              :decimal(22, 6)
#  other_expenses              :decimal(22, 6)
#  listing_exchange            :string(64)
#  asset_class                 :string(28)
#  development_class           :string(32)
#  focus                       :string(28)
#  lead_market_maker           :string(128)
#  region                      :string(28)
#  levered_amount              :decimal(22, 6)
#  maturity_date               :date
#  exposure_country            :string(64)
#  selection_criteria          :string(32)
#  weighting_scheme            :string(32)
#  administrator               :string(128)
#  advisor                     :string(128)
#  distributor                 :string(128)
#  fee_waivers                 :decimal(22, 6)
#  fiscal_year_end             :string(16)
#  futures_commission_merchant :string(128)
#  subadvisor                  :string(128)
#  tax_classification          :string(128)
#  transfer_agent              :string(50)
#  trustee                     :string(128)
#  creation_fee                :decimal(22, 6)
#  creation_unit_size          :decimal(22, 6)
#  custodian                   :string(128)
#  distribution_frequency      :string(32)
#  management_fee              :decimal(22, 6)
#  portfolio_manager           :string(128)
#  primary_benchmark           :string
#  match                       :boolean          default(FALSE), not null
#  exclude_from_ts             :boolean          default(FALSE), not null
#  base_currency               :string(16)
#

require 'rails_helper'

RSpec.describe StagingComposite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
