require 'csv'

ds_id = Datasource.find_by_data_source_name('BMO').id

if File.exists?('BMO ETF Tickers - SD.csv') and (0 == DfCompositeIdentifier.where(:datasource_id => ds_id).count)
  CSV.foreach("BMO ETF Tickers - SD.csv", :headers => true) do |line|
    next if 7 != line.count or line[0].blank?
    
    DfCompositeIdentifier.create(:datasource_id => ds_id,
                                 :ticker => line[0],
                                 :name => line[1],
                                 :isin => line[2],
                                 :cusip => line[3],
                                 :figi => line[5])
   end
end
