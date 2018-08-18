require 'fileutils'

namespace :jpm do
  desc "Date JPM NAV files"
  task :make_filenames_atomic, [:filepath] => :environment do |t, args|
    # args[:coasdf]
    errors = 0
    successes = 0
    
    files = Dir["#{args[:filepath]}/raw/FlexsharesALLNAVFTP*"]
    files.each do |fname|
      begin
        date = nil
        File.open(fname).each do |line|
          fields = line.split(/,/)
	        date = Date.strptime(fields[2].gsub('"',''), '%m/%d/%y')
          break
        end
        
        if date.nil?
          puts "Could not find date in #{fname}"
          errors += 1
        else          
          rename = "#{args[:filepath]}/Flexshares_NAV.#{date.strftime('%Y%m%d')}.csv"
          File.open(rename, 'w') do |fout|
            first = true
            
            File.open(fname).each do |line|
              if first
                first = false
              else
                fout.puts line
              end
            end
          end
          
          FileUtils.rm(fname)
          successes += 1
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
        File.open(rename, 'w') do |fout|
          header = true
          
          File.open(fname).each do |line|
            if header
              if line =~ /Account Number/
                header = false
              else
                next
              end
            end
            
            fout.puts line
          end
        end
        
        FileUtils.rm(fname)
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
