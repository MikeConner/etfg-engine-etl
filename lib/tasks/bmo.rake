namespace :db do
  desc "transform BMO composites"
  task :transform_composites, [:target_date, :filepath] => :environment do |t, args|
    # args[:coasdf]
    job = Kiba.parse do
      source BmoBasketsSource, args[:filepath]
      transform BmoBasketsTransformer, :target_date => args[:target_date]
      destination BmoBasketsDestination
    end
    
    Kiba.run(job)      
  end

  desc "transform BMO constituents"
  task :transform_constituents, [:target_date, :filepath] => :environment do |t, args|
    # args[:coasdf]
    job = Kiba.parse do
      source CSVSource, args[:filepath], :headers => true, :liberal_parsing => true
      transform BmoHoldingsTransformer, :target_date => args[:target_date]
      destination BmoHoldingsDestination
    end
    
    Kiba.run(job)      
  end
end
