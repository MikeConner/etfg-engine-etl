require 'csv'

=begin
To copy from the server db to local rails,

pg_dump --encoding=utf8 --no-owner -t public.ambiguous_instruments etfg > ambiguous_instruments.sql

Then at the rails console destination:

psql etfg_etl -f ambiguous_instruments.sql 
=end

if File.exists?('composite_figis.csv') and (0 == CompositeFigi.count)
  CSV.foreach("composite_figis.csv") do |line|
    CompositeFigi.create(:figi => line[0],
                         :composite_figi => line[1],
                         :created_at => line[2],
                         :ticker => line[3],
                         :name => line[4],
                         :security_type => line[5],
                         :market_sector => line[6],
                         :exchange_code => line[7],
                         :unique_id => line[8].strip,
                         :description => line[9],
                         :iso_country => line[10])
  end
end

["MasterDataReports", "FirstBridge", "VelocityShares", "PurposeHoldings", "Gsam", "Yahoo", "Xignite", "NYSE", "Nasdaq", "ShortSqueeze", "HOD", "ETPR", 
 "RBC", "AGFi", "BMO", "CanadianMint", "Harvest", "SSC", "BNY", "BlackRock", "Vanguard", "Barclays", "Sei", "BBH", "Gemini", "Citi", "JPMorgan", 
 "USBank"].each do |ds|
   Datasource.create(:data_source_name => ds)
 end

if File.exists?('instruments.csv') and (0 == Instrument.count)
  CSV.foreach("instruments.csv") do |line|
    Instrument.create(:issuer_id => line[0],
                      :issuer => line[1],
                      :ticker => line[2],
                      :name_variants => line[3],
                      :effective_date => line[4],
                      :expiration_date => line[5],
                      :figi => line[6],
                      :is_exchange_figi => line[7],
                      :sedol => line[8],
                      :isin => line[9],
                      :cusip => line[10],
                      :exchange_country => line[11],
                      :currency => line[12],
                      :exchange => line[13],
                      :market_sector => line[14],
                      :security_type => line[15],
                      :sector => line[16],
                      :industry => line[17],
                      :master_guid => line[18],
                      :industry_group => line[19],
                      :subindustry => line[20],
                      :rating => line[21],
                      :approved => line[22],
                      :is_valid => line[23],
                      :default_instrument => line[24],
                      :created_at => line[25],
                      :standard_name => line[26],
                      :pooled_instrument_id => line[27],
                      :instrument_id => line[28])
  end
end

if File.exists?('issuer_variants.csv') and (0 == Issuer.count)
  CSV.foreach("issuer_variants.csv") do |line|
    Issuer.create(:name => line[0])
    IssuerVariant.create(:name => line[0], :datasource_id => line[1], :issuer_id => line[2])
  end
end

if File.exists?('pooled_instruments.csv') and (0 == PooledInstrument.count)
  CSV.foreach("pooled_instruments.csv") do |line|
    PooledInstrument.create(:issuer_id => line[0],
                            :instrument_id => line[1],
                            :issuer => line[2],
                            :composite_ticker => line[3],
                            :composite_name_variants => line[4],
                            :standard_composite_name => line[5],
                            :composite_description => line[6],
                            :effective_date => line[7],
                            :expiration_date => line[8],
                            :exchange_country => line[9],
                            :is_index => line[10],
                            :is_active => line[11],
                            :is_etn => line[12],
                            :is_levered => line[13],
                            :is_inverse => line[14],
                            :has_derivatives => line[15],
                            :options_available => line[16],
                            :inception_date => line[17],
                            :etp_structure_type => line[18],
                            :category => line[19],
                            :related_index => line[20],      
                            :related_index_symbol => line[21],
                            :related_index_name => line[22],
                            :net_expenses => line[23],
                            :expense_ratio => line[24],
                            :listing_exchange => line[25],
                            :asset_class => line[26],
                            :development_class => line[27],
                            :focus => line[28],
                            :lead_market_maker => line[29],
                            :region => line[30],
                            :levered_amount => line[31],
                            :maturity_date => line[32],
                            :exposure_country => line[33],
                            :selection_criteria => line[34],
                            :weighting_scheme => line[35],
                            :administrator => line[36],
                            :advisor => line[37],
                            :distributor => line[38],
                            :fee_waivers => line[39],
                            :fiscal_year_end => line[40],
                            :futures_commission_merchant => line[41],
                            :subadvisor => line[42],
                            :tax_classification => line[43],
                            :transfer_agent => line[44],
                            :trustee => line[45],
                            :creation_fee => line[46],
                            :creation_unit_size => line[47],
                            :custodian => line[48],
                            :distribution_frequency => line[49],
                            :management_fee => line[50],
                            :portfolio_manager => line[51],
                            :primary_benchmark => line[52],
                            :total_expenses => line[53],
                            :other_expenses => line[54],
                            :approved => line[55],
                            :pooled_instrument_id => line[56],
                            :created_at => line[57],)
  end
end
