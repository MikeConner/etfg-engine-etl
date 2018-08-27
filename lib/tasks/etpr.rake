require 'csv'

namespace :db do
  # Run 1-6 in order (it is order dependent, to avoid ovewriting fields)
  
  def update_composite_name(pi, cname)
    updated = 0
    
    unless cname.blank? 
      name = cname.strip.gsub(',','')
      unless name.length > 128 or pi.composite_name_variants.include?(name)
        value = pi.composite_name_variants + "," + name
        pi.update_attribute(:composite_name_variants, value)    
        updated = 1
      end      
    end    
    
    updated
  end

  # A 1-off that is only for creating instruments not found in the seed file
  desc "Add seed instruments"
  task :add_seed_instruments do
    issuer = Issuer.find_by_name('Bank of Montreal')
    name = 'MicroSectors FANG+ Index 2X Leveraged ETN'
    ticker = 'FNGO'
    
    i = Instrument.create(:issuer_id => issuer.id,
                          :issuer => issuer.name,
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00LLY1GD4', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'NYSE Arca, Inc.',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:issuer_id => issuer.id,
                                 :instrument_id => i.id,
                                 :issuer => issuer.name,
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :exchange_country => 'US',
                                 :listing_exchange => 'NYSE Arca, Inc.',
                                 :inception_date => Date.strptime('8/1/18', "%m/%d/%y"),
                                 :maturity_date => Date.strptime('1/8/38', "%m/%d/%y"),
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)
  
    name = 'MicroSectors FANG+ Index -2X Inverse Leveraged ETNs'
    ticker = 'FNGZ'
    
    i = Instrument.create(:issuer_id => issuer.id,
                          :issuer => issuer.name,
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00LLY1DP8', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'NYSE Arca, Inc.',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:issuer_id => issuer.id,
                                 :instrument_id => i.id,
                                 :issuer => issuer.name,
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :exchange_country => 'US',
                                 :listing_exchange => 'NYSE Arca, Inc.',
                                 :inception_date => Date.strptime('8/1/18', "%m/%d/%y"),
                                 :maturity_date => Date.strptime('1/8/38', "%m/%d/%y"),
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)
  
    name = 'MicroSectors FANG+ Index Inverse ETN'
    ticker = 'GNAF'
    
    i = Instrument.create(:issuer_id => issuer.id,
                          :issuer => issuer.name,
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00LLY1M32', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'NYSE Arca, Inc.',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:issuer_id => issuer.id,
                                 :instrument_id => i.id,
                                 :issuer => issuer.name,
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :exchange_country => 'US',
                                 :listing_exchange => 'NYSE Arca, Inc.',
                                 :inception_date => Date.strptime('8/1/18', "%m/%d/%y"),
                                 :maturity_date => Date.strptime('1/8/38', "%m/%d/%y"),
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)

    name = 'Causeway Global Value NextShares'
    ticker = 'CGVIC'
    
    i = Instrument.create(:issuer => 'Causeway ETMF Trust',
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00KKCWQB1', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'The NASDAQ Stock Market LLC',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:instrument_id => i.id,
                                 :issuer => 'Causeway ETMF Trust',
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :portfolio_manager => 'Sarah H. Ketterer, Harry W. Hartford, James A. Doyle, Jonathan P. Eng, Conor Muldoon, Foster Corwith, Alessandro Valentini, Ellen Lee',
                                 :exchange_country => 'US',
                                 :listing_exchange => 'The NASDAQ Stock Market LLC',
                                 :transfer_agent => 'The Bank of New York Mellon Corporation',
                                 :tax_classification => 'Regulated Investment Company',
                                 :creation_unit_size => 25000,
                                 :net_expenses => 1.05,
                                 :other_expenses => 4.82,
                                 :total_expenses => 5.62,
                                 :management_fee => 0.8,
                                 :fee_waivers => -4.57,
                                 :creation_fee => 0,
                                 :distribution_frequency => 'A',
                                 :custodian => 'The Bank of New York Mellon Corporation',
                                 :distributor => 'SEI Investments Distribution Co.',
                                 :administrator => 'SEI Investments Global Funds Services',
                                 :advisor => 'Causeway Capital Management LLC',
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)

    name = 'Causeway International Value NextShares'
    ticker = 'CIVEC'
    
    i = Instrument.create(:issuer => 'Causeway ETMF Trust',
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00KKCWV93', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'The NASDAQ Stock Market LLC',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:instrument_id => i.id,
                                 :issuer => 'Causeway ETMF Trust',
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :portfolio_manager => 'Sarah H. Ketterer, Harry W. Hartford, James A. Doyle, Jonathan P. Eng, Conor Muldoon, Foster Corwith, Alessandro Valentini, Ellen Lee',
                                 :exchange_country => 'US',
                                 :listing_exchange => 'The NASDAQ Stock Market LLC',
                                 :transfer_agent => 'The Bank of New York Mellon Corporation',
                                 :tax_classification => 'Regulated Investment Company',
                                 :creation_unit_size => 25000,
                                 :net_expenses => 1.05,
                                 :other_expenses => 5.22,
                                 :total_expenses => 6.02,
                                 :management_fee => 0.8,
                                 :fee_waivers => -4.97,
                                 :creation_fee => 0,
                                 :distribution_frequency => 'A',
                                 :custodian => 'The Bank of New York Mellon Corporation',
                                 :distributor => 'SEI Investments Distribution Co.',
                                 :administrator => 'SEI Investments Global Funds Services',
                                 :advisor => 'Causeway Capital Management LLC',
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)

    name = 'Gabelli RBI NextShares'
    ticker = 'GRBIC'
    issuer = Issuer.find_by_name('Gabelli')
    
    i = Instrument.create(:issuer_id => issuer.id,
                          :issuer => issuer.name,
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00K4XXDX7', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'The NASDAQ Stock Market LLC',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:instrument_id => i.id,
                                 :issuer => issuer.name,
                                 :issuer_id => issuer.id,
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :portfolio_manager => 'Brian Sponheimer, Jose Garza',
                                 :exchange_country => 'US',
                                 :listing_exchange => 'The NASDAQ Stock Market LLC',
                                 :transfer_agent => 'The Bank of New York Mellon Corporation',
                                 :tax_classification => 'Regulated Investment Company',
                                 :creation_unit_size => 25000,
                                 :net_expenses => 0.9,
                                 :other_expenses => 1.4,
                                 :total_expenses => 2.4,
                                 :management_fee => 1.0,
                                 :fee_waivers => -1.5,
                                 :creation_fee => 0,
                                 :fiscal_year_end => Date.strptime('9/30/18', "%m/%d/%y"),
                                 :inception_date => Date.strptime('2/21/18', "%m/%d/%y"),
                                 :distribution_frequency => 'A',
                                 :custodian => 'The Bank of New York Mellon Corporation',
                                 :distributor => 'G.distributors, LLC',
                                 :administrator => 'Gabelli Funds, LLC',
                                 :advisor => 'Gabelli Funds, LLC',
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)

    name = "Gabelli Pet Parents' NextShares"
    ticker = 'PETZC'
    issuer = Issuer.find_by_name('Gabelli')
    
    i = Instrument.create(:issuer_id => issuer.id,
                          :issuer => issuer.name,
                          :ticker => ticker, 
                          :name_variants => name,
                          :standard_name => name,                         
                          :figi => 'BBG00L5DSCK0', 
                          :is_exchange_figi => false,
                          :exchange_country => 'US',
                          :currency => 'USD',
                          :exchange => 'The NASDAQ Stock Market LLC',
                          :approved => true,
                          :is_valid => true)
    i.update_attribute(:instrument_id, i.id)
    
    pi = PooledInstrument.create(:instrument_id => i.id,
                                 :issuer => issuer.name,
                                 :issuer_id => issuer.id,
                                 :composite_ticker => ticker,
                                 :composite_name_variants => name,
                                 :standard_composite_name => name,
                                 :portfolio_manager => 'Daniel M. Miller',
                                 :exchange_country => 'US',
                                 :listing_exchange => 'The NASDAQ Stock Market LLC',
                                 :transfer_agent => 'The Bank of New York Mellon Corporation',
                                 :tax_classification => 'Regulated Investment Company',
                                 :creation_unit_size => 25000,
                                 :net_expenses => 0.9,
                                 :other_expenses => 3.58,
                                 :total_expenses => 4.58,
                                 :management_fee => 1.0,
                                 :fee_waivers => -3.68,
                                 :creation_fee => 9999,
                                 :inception_date => Date.strptime('2/21/18', "%m/%d/%y"),
                                 :fiscal_year_end => Date.strptime('9/30/18', "%m/%d/%y"),
                                 :distribution_frequency => 'A',
                                 :custodian => 'The Bank of New York Mellon Corporation',
                                 :distributor => 'G.distributors, LLC',
                                 :administrator => 'Gabelli Funds, LLC',
                                 :advisor => 'Gabelli Funds, LLC',
                                 :approved => true)
    pi.update_attribute(:pooled_instrument_id, pi.id)
    i.update_attribute(:pooled_instrument_id, pi.id)
  end
  
  desc "Import RIC"
  task :import_etpr6 => :environment do
    updates = 0
    misses = 0
    found = 0
    CSV.foreach('etpr_ric_etp_expenses_rpt 8.17.18.csv') do |row|
      # 0 id
      # 1 ticker
      # 2 issue_name
      # 3 management_fee -> management_fee
      # 4 other_expenses -> other_expenses
      # 5 total_expenses -> total_expenses
      # 6 fee_waivers -> fee_waivers
      # 7 net_expenses -> net_expenses
      pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[1], 'US')
      if pi.nil?
        puts "#{row[1]} not found"
        misses += 1
      else
        found += 1
        puts found if 0 == found % 10

        updates += update_composite_name(pi, row[2])
        
        # Ok to overwrite; this is a much longer file; 
        #  we're assuming if 5 and 6 have the same tickers, the numbers are the same
        unless row[3].blank? 
          pi.update_attribute(:management_fee, row[3])
          updates += 1          
        end

        unless row[4].blank? 
          pi.update_attribute(:other_expenses, row[4])
          updates += 1          
        end

        unless row[5].blank? 
          pi.update_attribute(:total_expenses, row[5])
          updates += 1          
        end

        unless row[6].blank? 
          pi.update_attribute(:fee_waivers, row[6])
          updates += 1          
        end

        unless row[7].blank? 
          pi.update_attribute(:net_expenses, row[7])
          updates += 1          
        end
      end
    end    
    
    puts "Updates: #{updates}"
    puts "Misses: #{misses}"
    puts "Found: #{found}"
  end
  
  desc "Import non RIC"
  task :import_etpr5 => :environment do
    updates = 0
    misses = 0
    found = 0
    CSV.foreach('etpr_non_ric_etp_expenses_rpt 8.17.18.csv') do |row|
      # 0 id
      # 1 ticker
      # 2 issue_name
      # 3 management_fee -> management_fee
      # 4 other_expenses -> other_expenses
      # 5 total_expenses -> total_expenses
      # 6 fee_waivers -> fee_waivers
      # 7 net_expenses -> net_expenses
      # 8 source
      # 9 source_date    
      pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[1], 'US')
      if pi.nil?
        puts "#{row[1]} not found"
        misses += 1
      else
        found += 1
        puts found if 0 == found % 10

        updates += update_composite_name(pi, row[2])
        
        unless row[3].blank?
          pi.update_attribute(:management_fee, row[3])
          updates += 1          
        end

        unless row[4].blank?
          pi.update_attribute(:other_expenses, row[4])
          updates += 1          
        end

        unless row[5].blank?
          pi.update_attribute(:total_expenses, row[5])
          updates += 1          
        end

        unless row[6].blank?
          pi.update_attribute(:fee_waivers, row[6])
          updates += 1          
        end

        unless row[7].blank?
          pi.update_attribute(:net_expenses, row[7])
          updates += 1          
        end
      end
    end    
    
    puts "Updates: #{updates}"
    puts "Misses: #{misses}"
    puts "Found: #{found}"
  end
  
  desc "Import ETPR Tax"
  task :import_etpr4 => :environment do
    updates = 0
    misses = 0
    found = 0
    CSV.foreach('etpr_etp_tax_classification_rpt 8.20.18.csv') do |row|
      # 0 id
      # 1 ticker
      # 2 issue_name
      # 3 tax_classification    
      pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[1], 'US')
      if pi.nil?
        puts "#{row[1]} not found"
        misses += 1
      else
        found += 1
        puts found if 0 == found % 10

        updates += update_composite_name(pi, row[2])
       
        unless row[3].blank?
          pi.update_attribute(:tax_classification, row[3].strip)
          updates += 1
        end
      end
    end
    
    puts "Updates: #{updates}"
    puts "Misses: #{misses}"
    puts "Found: #{found}"
  end
  
  desc "Import ETPR Service"
  task :import_etpr3 => :environment do
    updates = 0
    misses = 0
    found = 0
    CSV.foreach('etpr_etp_service_providers_rpt 8.20.18.csv') do |row|
      # 0 id
      # 1 ticker -> composite_ticker
      # 2 issue_name -> composite_name
      # 3 administrator -> administrator
      # 4 advisor -> advisor
      # 5 commodity_pool_operator
      # 6 commodity_trading_advisor
      # 7 custodian -> custodian
      # 8 depositor
      # 9 depository
      # 10 distributor -> distributor
      # 11 futures_commission_merchant -> futures_commission_merchant
      # 12 general_partner
      # 13 marketing_agent
      # 14 pool_manager
      # 15 pool_tax_administrator
      # 16 portfolio_manager -> portfolio_manager
      # 17 subadvisor -> subadvisor
      # 18 trust_processing_agent
      # 19 transfer_agent -> transfer_agent
      # 20 trust_sponsor
      # 21 trustee -> trustee
      pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[1], 'US')
      if pi.nil?
        puts "#{row[1]} not found"
        misses += 1
      else
        found += 1
        puts found if 0 == found % 10

        updates += update_composite_name(pi, row[2])
        
        unless row[3].blank?
          pi.update_attribute(:administrator, row[3].strip)
          updates += 1
        end

        unless row[4].blank?
          pi.update_attribute(:advisor, row[4].strip)
          updates += 1
        end

        unless row[7].blank?
          pi.update_attribute(:custodian, row[7].strip)
          updates += 1
        end

        unless row[10].blank?
          pi.update_attribute(:distributor, row[10].strip)
          updates += 1
        end

        unless row[11].blank?
          pi.update_attribute(:futures_commission_merchant, row[11].strip)
          updates += 1
        end

        unless row[16].blank?
          pi.update_attribute(:portfolio_manager, row[16].strip)
          updates += 1
        end

        unless row[17].blank?
          pi.update_attribute(:subadvisor, row[17].strip)
          updates += 1
        end

        unless row[19].blank?
          pi.update_attribute(:transfer_agent, row[19].strip)
          updates += 1
        end

        unless row[21].blank?
          pi.update_attribute(:trustee, row[21].strip)
          updates += 1
        end
      end
    end
    
    puts "Updates: #{updates}"
    puts "Misses: #{misses}"
    puts "Found: #{found}"
  end
  
  desc "Import ETPR File 2"
  task :import_etpr2 => :environment do
    updates = 0
    misses = 0
    found = 0
    # 0 id
    # 1 ticker -> composite_ticker
    # 2 issue_name -> composite_name
    # 3 issuer_name
    # 4 inception_date -> inception_date
    # 5 listing_date
    # 6 fiscal_year_end -> fiscal_year_end
    # 7 distribution_frequency -> distribution_frequency
    # 8 listing_exchange -> listing_exchange
    # 9 creation_unit_size -> creation_unit_size
    # 10 creation_fee -> creation_fee
    CSV.foreach('etpr_etp_additional_content_rpt 8.21.18.csv') do |row|
      pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[1], 'US')
      if pi.nil?
        puts "#{row[1]} not found"
        misses += 1
      else
        found += 1
        puts found if 0 == found % 10
                
        updates += update_composite_name(pi, row[2])
      
        # These run in order, so don't overwrite previous values
        unless row[4].blank? or not pi.inception_date.blank?
          pi.update_attribute(:inception_date, Date.strptime(row[4], "%m/%d/%y"))
          updates += 1
        end

        unless row[6].blank?
          pi.update_attribute(:fiscal_year_end, Date.strptime(row[6], "%m/%d/%y"))
          updates += 1
        end

        unless row[7].blank?
          pi.update_attribute(:distribution_frequency, row[7].strip)
          updates += 1
        end

        unless row[8].blank?
          pi.update_attribute(:listing_exchange, row[8])
          updates += 1
        end

        unless row[9].blank?
          pi.update_attribute(:creation_unit_size, row[9])
          updates += 1
        end

        unless row[10].blank?
          pi.update_attribute(:creation_fee, row[10])
          updates += 1
        end
      end      
    end
    
    puts "Updates: #{updates}"
    puts "Misses: #{misses}"
    puts "Found: #{found}"
  end

  desc "Import EPTR data"
  task :import_etpr => :environment do
    # 0 id
    # 1 ticker -> composite_ticker
    # 2 issue_name -> composite_description
    # 3 inception_date -> inception_date
    # 4 maturity_date -> maturity_date
    # 5 issuer_name -> issuer (and issuer_id)
    # 6 listing_exchange -> listing_exchange
    updates = 0
    misses = 0
    found = 0
          
    CSV.foreach('etpr_etn_directory_rpt 8.17.18.csv') do |row|
      pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[1], 'US')
 
      if pi.nil?
        puts "#{row[1]} not found"
        misses += 1
      else
        found += 1
        puts found if 0 == found % 10
        
        updates += update_composite_name(pi, row[2])
     
        unless row[3].blank?
          pi.update_attribute(:inception_date, Date.strptime(row[3], "%m/%d/%y"))
          updates += 1
        end
        
        unless row[4].blank?
          pi.update_attribute(:maturity_date, Date.strptime(row[4], "%m/%d/%y"))
          updates += 1
        end
              
        unless row[6].blank?
          pi.update_attribute(:listing_exchange, row[6])
          updates += 1
        end
      end
    end
    
    puts "Updates: #{updates}"
    puts "Misses: #{misses}"
    puts "Found: #{found}"
  end
end
