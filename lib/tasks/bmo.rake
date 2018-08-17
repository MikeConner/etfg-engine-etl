namespace :bmo do
  desc "transform BMO baskets"
  task :transform_baskets, [:target_date, :filepath] => :environment do |t, args|
    # args[:coasdf]
    job = Kiba.parse do
      source BmoBasketsSource, args[:filepath]
      transform BmoBasketsTransformer, :target_date => args[:target_date]
      destination BmoBasketsDestination
    end
    
    Kiba.run(job)      
  end

  desc "transform BMO holdings"
  task :transform_holdings, [:target_date, :filepath] => :environment do |t, args|
    job = Kiba.parse do
      source CSVSource, args[:filepath], 7, {:headers => true, :liberal_parsing => true, :encoding => 'iso-8859-1:utf-8'}
      transform BmoHoldingsTransformer, :target_date => args[:target_date]
      destination BmoHoldingsDestination
    end
    
    Kiba.run(job)      
  end
end
