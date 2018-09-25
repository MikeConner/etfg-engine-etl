require 'csv'

namespace :ssc do
  desc "Seed Lookup file"
  task :seed_lookup, [:filepath] => :environment do |t, args|
    SscLookup.destroy_all
    
    CSV.foreach(args[:filepath], :headers => true) do |line|
      SscLookup.create(:fund_id => line[0],
                       :fund_name => line[1],
                       :ticker => line[2])
    end 
  end
end
