namespace :ubs do
  desc "Extract as of date (nav)"
  task :extract_date_nav, [:path, :date_str] => :environment do |t, args|  
    fin = "#{args[:path]}/ETRACS_Report_#{args[:date_str]}.csv"
    fout = "#{args[:path]}/UBS_NAV.#{args[:date_str]}.csv"
    puts "Copying: #{fin} to #{fout}"
    # Now copy from filename to final, extracting as_of_date and adding the as_of_date column
    header = true
    date = nil
    date_str = nil
    CSV.open(fout, 'w') do |csv|
      csv << ['Product Name','Exchange Trading Symbol','Intraday Indicative Value Symbol (Index)',
              'Intraday Indicative Value','Shares Outstanding Symbol (Index)','Shares Outstanding',
              'Market Value','Source','As Of Date']

      CSV.foreach(fin) do |row|
        if header
          if not row[1].blank? and row[1] =~ /Trade Date: (.*)/
            date = Date.strptime($1, '%d %b %Y')
            date_str = date.strftime('%Y%m%d')
          elsif 'Product Name' == row[0]
            header = false
          end
        else
          break if row[0] =~ /\AThis info/
          csv << row[0..7] + [date_str] unless row[0].blank?
        end
      end
    end
    
    if header or date.nil?
      raise "Could not find content in #{fname}"
    end
  end
end
