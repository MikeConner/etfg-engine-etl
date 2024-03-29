require 'fileutils'

namespace :jpms do
  desc "Date JPM Securities files"
  task :make_filenames_atomic, [:filepath, :convert_xml] => :environment do |t, args|    
    process_file(args[:filepath], "CW_PROFUND_*_AllPositionsTemplate", "CW_PROFUND")
    # Turning off FFCM
    #process_file(args[:filepath], "CW_FFCM_*_FQFTrustPricedPositionsforETFGlobal", "CW_FFCM")
    # Can add a row count if you want to delete malformed lines
    # (Will silently fail for "short" files, though)
    process_file(args[:filepath], "reortega_*_O_SharesPositionsforETFGlobal", "REO_OShares")
    # These files don't have dates
    #process_file(args[:filepath], "reortega_*_ETFSTrustPositionstoETFG", "REO_RelMgr")
    # Skip these, since there are no dates!
    # process_file(args[:filepath], "reortega_*_ETFSTrustPositionstoETFG.csv", "REO_ETFSTrust")
    
    # Just copy ProShares and OShares; they're already dated
    copy_dated_file(args[:filepath], "ProSharesAllnavs.*")
    copy_dated_file(args[:filepath], "OSharesAllnavs.*")
    
    # QuantShares_ALLNAV_02082018.xlsx
    # Convert to CSV first
    convert_to_csv(args[:filepath], "QuantShares_ALLNAV_*.xls*", "QuantShares_ALLNAV_(\\d+).(xlsx?)", "QuantShares_ALLNAV")
    if args.has_key?(:convert_xml) and ('convert_xml' == args[:convert_xml])
      convert_ffcm(args[:filepath], "FFCM_Positions_for_Morningstar_*", "FFCM_Positions")      
    end
  end

  # This doesn't work on Digital Ocean - do in Python instead
  def convert_ffcm(path, pattern, replacement)
    errors = 0
    successes = 0

    # If necessary, convert to csv (will work whether it sends xls or pre-converted csv)
    files = Dir["#{path}/raw/#{pattern}.xml"]
    files.each do |fname|
      puts "Converting #{fname}"
      rename = fname.gsub(/\.xml/, '.csv')
      excel = Roo::Spreadsheet.open(fname, :extension => 'xml')
      
      File.open(rename, 'w') do |fout|            
        1.upto(excel.last_row) do |line|
          fout.write CSV.generate_line excel.row(line)
        end            
      end  
      FileUtils.rm(fname)    
    end
    
    # Now process the csv file
    files = Dir["#{path}/raw/#{pattern}.csv"]
    files.each do |fname|
      begin
        date = nil
        puts "Reading #{fname}"
        File.open(fname).each do |line|
          s = line.gsub('"', '')
          break if line =~ /\AEffective/i
          
          if s =~ /As Of Date: (.*)/i
             date = Date.strptime($1, '%d-%b-%Y')
             break
          end 
        end
        
        if date.nil?
          puts "Could not find date in #{fname}"
          errors += 1
        else          
          rename = "#{path}/#{replacement}.#{date.strftime('%Y%m%d')}.csv"
          puts "Writing #{rename}"
          header = true

          File.open(rename, 'w') do |fout|            
            File.open(fname).each do |line|
              if header
                if line.gsub('"', '') =~ /\AEffective/
                  header = false
                  fout.puts line
                end
              else
                fout.puts line
              end
            end
          end
          
          if header
            puts "Could not find content in #{fname}"
            errors += 1
          else
            FileUtils.rm(fname)
            successes += 1
          end
        end
      rescue Exception => ex
        puts "Could not process #{fname}: #{ex.message}"
        errors += 1
      end
    end   
    
    if errors > 1
      raise "Conversion errors: #{errors} (Converted: #{successes})"
    end
  end
  
  def convert_to_csv(path, pattern, re_pattern, replacement)  
    errors = 0
    successes = 0

    files = Dir["#{path}/raw/#{pattern}"]
    files.each do |fname|
      begin
        regex = Regexp.compile(re_pattern)
        md = regex.match(fname)
        unless md.nil?
          date_str = md[1]
          file_ext = md[2]
          
          date = Date.strptime(date_str, "%m%d%Y")
          
          rename = "#{path}/raw/#{replacement}.#{date.strftime('%Y%m%d')}.csv"
          final = "#{path}/#{replacement}.#{date.strftime('%Y%m%d')}.csv"
          puts "Writing #{rename}"
          
          excel = 'xlsx' == file_ext ? Roo::Excelx.new(fname) : Roo::Excel.new(fname)
          
          header = true
          File.open(rename, 'w') do |fout|            
            1.upto(excel.last_row) do |line|
              if header
                if 'Fund Name' == excel.cell(line, 1)
                  header = false
                  fout.write CSV.generate_line excel.row(line)
                end
              else                
                fout.write CSV.generate_line excel.row(line)
              end
            end            
          end
          
          if header
            puts "Could not find content in #{rename}"
            errors += 1
          else
            # strip non-ascii from converted csv, and move to top level
            `perl -i.bak -pe 's/[^[:ascii:]]//g' #{rename}`
            FileUtils.copy_file(rename, final)
            
            # remove originals
            FileUtils.rm(fname)
            FileUtils.rm(rename)
            FileUtils.rm("#{rename}.bak")
            successes += 1
          end
        end
      rescue Exception => ex
        puts "Could not process #{fname}: #{ex.message}"
        errors += 1
      end
    end   

    if errors > 1
      raise "Conversion errors: #{errors} (Converted: #{successes})"
    end
  end
    
  def copy_dated_file(path, pattern)
    errors = 0
    successes = 0

    files = Dir["#{path}/raw/#{pattern}.csv"]
    files.each do |fname|
      begin
        # This gets the fname.date.csv (date is in the wrong format, and needs to be changed)
        fields = fname.split('/').last.split('.')
        date = Date.strptime(fields[1], "%m%d%Y")
        fields[1] = date.strftime("%Y%m%d")
        
        rename = "#{path}/#{fields.join(".")}"
        puts "Writing #{rename}"
        header = true
        File.open(rename, 'w') do |fout|         
          File.open(fname).each do |line|
            if header
              if line.gsub('"', '') =~ /\AFund Name/
                header = false
                fout.puts line
              end
            else
              fout.puts line unless line =~ /\A,/
            end
          end
        end
        
        if header
          puts "Could not find content in #{fname}"
          errors += 1
        else
          FileUtils.rm(fname) 
          successes += 1
        end
          
      rescue Exception => ex
        puts "Could not process #{fname}: #{ex.message}"
        errors += 1
      end 
    end

    if errors > 1
      raise "Conversion errors: #{errors} (Converted: #{successes})"
    end
  end
    
  def process_file(path, pattern, replacement, row_len = nil)
    errors = 0
    successes = 0

    files = Dir["#{path}/raw/#{pattern}.csv"]
    files.each do |fname|
      begin
        date = nil
        puts "Reading #{fname}"
        File.open(fname).each do |line|
          s = line.gsub('"', '')
          break if line =~ /\AAccount/i
          
          if s =~ /As Of Date: (.*)/i
             date = Date.strptime($1, '%d-%b-%Y')
             break
          end 
        end
        
        if date.nil?
          puts "Could not find date in #{fname}"
          errors += 1
        else          
          rename = "#{path}/#{replacement}.#{date.strftime('%Y%m%d')}.csv"
          puts "Writing #{rename}"
          header = true

          File.open(rename, 'w') do |fout|            
            File.open(fname).each do |line|
              if header
                if line.gsub('"', '') =~ /\AAccount/
                  header = false
                  fout.puts line
                end
              else
                fout.puts line if row_len.nil? or (row_len == line.split(',').count)
              end
            end
          end
          
          if header
            puts "Could not find content in #{fname}"
            errors += 1
          else
            FileUtils.rm(fname)
            successes += 1
          end
        end
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
