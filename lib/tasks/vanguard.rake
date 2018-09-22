namespace :vanguard do
  desc "Clear ETF feed to prevent duplicates"
  task :clear_etfs, [:target_date] => :environment do |t, args|
    VanguardEtf.where(:etfg_date => Date.parse(args[:target_date])).delete_all
  end
  
  desc "transform Vanguard ETFs"
  task :transform_etfs, [:target_date, :filepath] => :environment do |t, args|
    # args[:coasdf]
    job = Kiba.parse do
      source VanguardETFSource, args[:filepath]
      transform VanguardETFTransformer, :target_date => args[:target_date]
      destination VanguardETFDestination
    end
    
    Kiba.run(job)      
  end

  desc "transform Vanguard FI ETFs"
  task :transform_fi_etfs, [:target_date, :filepath] => :environment do |t, args|
    # args[:coasdf]
    job = Kiba.parse do
      source VanguardETFSource, args[:filepath]
      transform VanguardFITransformer, :target_date => args[:target_date]
      destination VanguardETFDestination
    end
    
    Kiba.run(job)      
  end

  desc "transform Vanguard Factor holdings"
  task :transform_factor_holdings, [:target_date, :filepath] => :environment do |t, args|
    job = Kiba.parse do
      source VanguardHoldingsSource, args[:filepath]
      transform VanguardFactorTransformer, :target_date => args[:target_date]
      destination VanguardFactorDestination
    end
    
    VanguardFactor.where(:etfg_date => Date.parse(args[:target_date])).delete_all

    Kiba.run(job)      
  end

  desc "transform Vanguard holdings"
  task :transform_holdings, [:target_date, :filepath] => :environment do |t, args|
    job = Kiba.parse do
      source VanguardHoldingsSource, args[:filepath]
      transform VanguardHoldingsTransformer, :target_date => args[:target_date]
      destination VanguardHoldingsDestination
    end
    
    VanguardHolding.where(:etfg_date => Date.parse(args[:target_date])).delete_all

    Kiba.run(job)      
  end
end
