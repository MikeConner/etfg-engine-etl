namespace :vanguard do
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

  desc "transform Vanguard holdings"
  task :transform_holdings, [:target_date, :filepath] => :environment do |t, args|
    job = Kiba.parse do
      #source CSVSource, args[:filepath], 7, {:headers => true, :liberal_parsing => true, :encoding => 'iso-8859-1:utf-8'}
      #transform BmoHoldingsTransformer, :target_date => args[:target_date]
      #destination BmoHoldingsDestination
    end
    
    Kiba.run(job)      
  end
end
