require 'fileutils'

namespace :jpm do
  desc "Date JPM NAV files"
  task :date_nav, [:filepath] => :environment do |t, args|
    # args[:coasdf]
    errors = 0
    successes = 0
    
    files = Dir["#{args[:filepath]}/raw/FlexsharesALLNAVFTP*"]
    files.each do |fname|
      begin
        File.open(fname).each do |line|
          fields = line.split(/,/)
	  date = Date.strptime(fields[2].gsub('"',''), '%m/%d/%y')
          
	  rename = "#{args[:filepath]}/Flexshares_NAV.#{date.strftime('%Y%m%d')}.csv"
          FileUtils.mv(fname, rename)
          successes += 1
          break
        end
        
      rescue Exception => ex
        puts "Could not process #{fname}: #{ex.message}"
        errors += 1
      end
    end
    
    files = Dir["#{args[:filepath]}/raw/CW_NORTHERNTQ_*"]
    files.each do |fname|
      begin
        idx = 0
        date = nil
        File.open(fname).each do |line|
          break if idx > 3
          
          if line =~ /As Of Date: (.*)/i
            date = Date.strptime($1.strip, '%d-%b-%Y')
	    break
          end
          
          idx += 1
        end
        
        if date.nil?
          puts "Could not extract date from #{fname}"
          errors += 1
          next
        end
        
        rename = "#{args[:filepath]}/Flexshares_Positions.#{date.strftime('%Y%m%d')}.csv"
        FileUtils.mv(fname, rename)
        successes += 1
      rescue Exception => ex
        puts "Could not process #{fname}: #{ex.message}"
        errors += 1
      end
    end
    
    if errors > 1
      raise "Conversion errors: #{errors} (Converted: #{successes})"
    end
  end
end