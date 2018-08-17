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
          puts line.strip
          date = Date.strptime(line.strip, '%m/%d/%y')
          break
        end
        
        rename = "Flexshares_NAV.#{date.strftime('%Y%m%d')}.csv"
        FileUtils.mv(fname, rename)
        successes += 1
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
          puts line
          
          if line =~ /As Of Date: (.*)/i
            date = Date.strptime($1.strip, '%d-%b-%Y')
          end
          
          idx += 1
        end
        
        if date.nil?
          puts "Could not extract date from #{fname}"
          errors += 1
          next
        end
        
        rename = "Flexshares_Positions.#{date.strftime('%Y%m%d')}.csv"
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
