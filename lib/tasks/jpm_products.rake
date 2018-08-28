namespace :jpmprod do
  desc "Extract as of date"
  task :extract_date, [:path, :filename] => :environment do |t, args|  
    regex = Regexp.compile("JPMIM_All_Positions_Template_(.*?)\.csv")
    md = regex.match(args[:filename])
    raise "Invalid filename" if md.nil?
    
    final = "#{args[:path]}/JPMIM_Positions.#{md[1]}.csv"
    puts "Writing: #{final}"
    # Now copy from filename to final, extracting as_of_date and adding the as_of_date column
    header = true
    date = nil
    CSV.open(final, 'w') do |csv|
      csv << ['As Of Date','Account Number','Account Name','Account Status','Base Currency Code','Asset ID','Security Qualifier',
              'Security Description','Shares Par','Market Price (Local)','Original Cost','Market Value','Unrealized Gain/Loss']

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
          csv << [date_str] + row unless row[0].blank?
        end
      end
    end
    
    if header or date.nil?
      raise "Could not find content in #{fname}"
    end
  end
end
