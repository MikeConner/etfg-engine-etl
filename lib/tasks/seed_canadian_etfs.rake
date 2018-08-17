require 'csv'

namespace :db do
  desc "Add Canadian ETFs"
  task :seed_canadian_etfs => :environment do
    if File.exists?('Canadian ETF Seed.csv')
      CSV.foreach("Canadian ETF Seed.csv") do |line|
        existing_pi = PooledInstrument.where(:exchange_country => 'CA', :composite_ticker => line[0]).first
        if existing_pi.nil?
          ActiveRecord::Base.transaction do
            pi = PooledInstrument.create(:composite_ticker => line[0],
                                         :composite_name_variants => line[3],
                                         :standard_composite_name => line[3],
                                         :composite_description => line[6],
                                         :exchange_country => 'CA',
                                         :is_index => false,
                                         :is_etn => true,
                                         :category => line[6],
                                         :listing_exchange => line[8],
                                         :asset_class => line[5],
                                         :approved => true)  
            i = Instrument.create(:ticker => line[0],
                                  :isin => line[1],
                                  :cusip => line[2],
                                  :secid => line[10],
                                  :figi => line[12],
                                  :name_variants => line[3],
                                  :standard_name => line[3],
                                  :exchange_country => 'CA',
                                  :currency => 'CAD',
                                  :exchange => line[8],
                                  :market_sector => line[5],
                                  :pooled_instrument_id => pi.id,
                                  :approved => true)  
            i.update_attribute(:instrument_id, i.id)
            pi.update_attributes(:instrument_id => i.id, :pooled_instrument_id => pi.id)
          end    
        else
          puts "#{line[0]} already found"
        end
      end 
    end
  end
end
