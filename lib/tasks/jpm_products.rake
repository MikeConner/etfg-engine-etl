namespace :jpmprod do
  desc "Extract as of date (nav)"
  task :extract_date_nav, [:path, :filename] => :environment do |t, args|  
    regex = Regexp.compile("JPMIM_Daily_ETF_Blastfax\.(.*?)\.csv")
    md = regex.match(args[:filename])
    raise "Invalid filename" if md.nil?
    # Flip year around
    date = Date.strptime(md[1], '%m%d%Y')
    date_str = date.strftime('%Y%m%d')
    
    final = "#{args[:path]}/JPMIM_nav.#{date_str}.csv"
    puts "Writing: #{final}"
    # Now copy from filename to final, extracting as_of_date and adding the as_of_date column
    header = true
    date = nil
    CSV.open(final, 'w') do |csv|
      csv << ['Fund Name','Ticker','CUSIP','NAV','Previous NAV','NAV Change','% OF NAV Change','Net Assets',
              'Shares Outstanding','Distribution Factor','Distributed Income','Daily Yield','ST Cap Gains','LT Cap Gains',
              'As Of Date']

      fname = "#{args[:path]}/#{args[:filename]}"   
      date_str = nil
         
      CSV.foreach(fname) do |row|
        if header
          if date_str.nil? and not row[1].blank?
             date = Date.strptime(row[1], '%m/%d/%y')
             date_str = date.strftime('%Y%m%d')
          elsif 'Fund Name' == row[0]
            header = false
          end
        else
          csv << row[0..13] + [date_str] unless row[0].blank?
        end
      end
    end
    
    if header or date.nil?
      raise "Could not find content in #{fname}"
    end
  end
  
  desc "Extract as of date (positions)"
  task :extract_date_pos, [:path, :filename] => :environment do |t, args|  
    regex = Regexp.compile("JPMIM_All_Positions_Template_(.*?)\.csv")
    md = regex.match(args[:filename])
    raise "Invalid filename" if md.nil?
    
    final = "#{args[:path]}/JPMIM_Positions.#{md[1]}.csv"
    puts "Writing: #{final}"
    # Now copy from filename to final, extracting as_of_date and adding the as_of_date column
    header = true
    date = nil
    CSV.open(final, 'w') do |csv|
      csv << ['Account Number','Account Name','Account Status','Base Currency Code','Asset ID','Security Qualifier',
              'Security Description','Shares Par','Market Price (Local)','Original Cost','Market Value','Unrealized Gain/Loss',
              'As Of Date']

      fname = "#{args[:path]}/#{args[:filename]}"   
      date_str = nil
         
      CSV.foreach(fname) do |row|
        if header
          if row[0] =~ /As Of Date: (.*)/i
             date = Date.strptime($1, '%d-%b-%Y')
             date_str = date.strftime('%Y%m%d')
          elsif 'Account Number' == row[0]
            header = false
          end
        else
          csv << row + [date_str] unless row[0].blank?
        end
      end
    end
    
    if header or date.nil?
      raise "Could not find content in #{fname}"
    end
  end
end
