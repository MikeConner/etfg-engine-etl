namespace :vanguard do
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

  desc "transform Vanguard Baskets"
  task :transform_baskets, [:target_date, :filepath] => :environment do |t, args|
    job = Kiba.parse do
      source VanguardBasketSource, args[:filepath]
      transform VanguardBasketTransformer, :target_date => args[:target_date]
      destination VanguardBasketDestination
    end
    
    VanguardBasket.where(:etfg_date => Date.parse(args[:target_date])).delete_all

    Kiba.run(job)      
  end
end
