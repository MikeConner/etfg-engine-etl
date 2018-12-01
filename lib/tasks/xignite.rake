require 'net/http'

namespace :xignite do
  XIGNITE_BASE_URL = 'https://factsetfundamentals.xignite.com/xFactSetFundamentals.json/GetFundamentals'
  API_TOKEN = '43B9650522614ABDBD4C9B5948287A93'
  
  desc "Update instruments"
  task :sector_industry, [:today] => :environment do |t, args| 
    uri = URI(XIGNITE_BASE_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    today = Date.strptime(args[:today], '%Y%m%d')

    params = { 'IdentifierType' => "CUSIP", 
               'FundamentalTypes' => 'Industry,Sector',
               'AsOfDate' => today.try(:strftime, '%m/%d/%Y'),
               'ReportType' => 'Annual',
               'ExcludeRestated' => 'False',
               'UpdatedSince' => '',
               '_token' => API_TOKEN }
    
    already_checked = XigniteApiCall.all.map(&:cusip)
    
    chunk = {}
    idx = 1
    Instrument.date_range(today).where("cusip IS NOT NULL AND (sector IS NULL OR industry IS NULL) AND cusip_validated='Valid'").each do |i|
      next if already_checked.include?(i.cusip) or chunk.values.include?(i.cusip)
      
      chunk[i.cusip] = i.id
      if 100 == chunk.count
        puts "Updating chunk #{idx}"
        update_chunk(chunk, uri, params, already_checked)
        chunk = {}
        idx += 1
      end
    end
    
    if chunk.count > 0
        puts "Updating last chunk #{idx}"
        update_chunk(chunk, uri, params, already_checked)      
    end    
  end
  
  def update_chunk(chunk, uri, params, already_checked)
    # Add params to URI
    params['Identifiers'] = chunk.keys.join(",")
    
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    if "200" == response.code
      body = JSON.parse(response.body)
      
      body.each do |a|
        if "Success" == a['Outcome']
          company = a['Company']
          
          industry = company['Industry']
          sector = company['Sector']
          cusip = company['CUSIP']
          if already_checked.include?(cusip)
            puts "Duplicate cusip #{cusip}"
          else
            begin
              XigniteApiCall.create!(:cusip => cusip, :industry => industry, :sector => sector, :data => a.to_json)
            rescue Exception => ex
              puts ex.message
            end
            already_checked.push(cusip)
          end
          
          # Don't update instrument just yet
          # i = Instrument.find(chunk[cusip])
          # unless industry.blank?
            # i.update_attribute(:industry, industry)
          # end
          # unless sector.blank?
            # i.update_attribute(:market_sector, sector)
          # end      
        else    
          msg = a['Message']
          if msg =~ /\((.*?)\)/
            begin
              XigniteApiCall.create!(:cusip => $1, :data => msg)
            rescue Exception => ex
              puts ex.message
            end
          end
        end
      end
    end
  end
end
