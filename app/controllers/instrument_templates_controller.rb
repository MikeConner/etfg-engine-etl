require 'csv'

class InstrumentTemplatesController < ApplicationController
  before_action :authenticate_user!

  def create
    @template = InstrumentTemplate.new(template_params)
    ok = @template.save
    if ok
      if @template.template_file.file.nil?
        @template.errors.add(:base, "ETPR instrument template file invalid") 
        ok = false
      end
    end

    if ok
      num_found = 0
      updates = 0
      today = Date.today
      
      # Read the file and set it
      CSV.foreach(@template.template_file.file.path, :headers => true) do |row|
        found = false
        
        as_of_date = parse_date(row[13]) rescue today
        
        i = Instrument.date_range_parsed(as_of_date).where(:instrument_id => row[0].to_i).first
        unless i.nil?
          found = true
          changes = {}
          if i.exchange_country.blank? and not row[1].blank?
            changes[:exchange_country] = row[1]
            updates += 1
          end
          if i.currency.blank? and not row[2].blank?
            changes[:currency] = row[2]
            updates += 1
          end
          if i.market_sector.blank? and not row[3].blank?
            changes[:market_sector] = row[3]
            updates += 1
          end
          if i.security_type.blank? and not row[4].blank?
            changes[:security_type] = row[4]
            updates += 1
          end
          if i.sector.blank? and not row[5].blank?
            changes[:sector] = row[5]
            updates += 1
          end
          if i.industry.blank? and not row[6].blank?
            changes[:industry] = row[6]
            updates += 1
          end
          if i.industry_group.blank? and not row[7].blank?
            changes[:industry_group] = row[7]
            updates += 1
          end
          if i.subindustry.blank? and not row[8].blank?
            changes[:subindustry] = row[8]
            updates += 1
          end
          if i.geography.blank? and not row[9].blank?
            changes[:geography] = row[9]
            updates += 1
          end
          if i.sedol.blank? and not row[10].blank?
            changes[:sedol] = row[10]
            updates += 1
          end
          if i.isin.blank? and not row[11].blank?
            changes[:isin] = row[11]
            updates += 1
          end
          if i.cusip.blank? and not row[12].blank?
            changes[:cusip] = row[12]
            updates += 1
          end
          if i.ticker.blank? and not row[14].blank?
            changes[:ticker] = row[14]
            updates += 1
          end
          
          i.update_attributes(changes)
        end
        
        num_found += 1 if found
      end
      
      stats = "#{num_found} found; #{updates} updated"
      
      redirect_to root_path, :notice => "Instrument template file uploaded (#{stats})"
    else
      redirect_to templates_path, :alert => @template.errors.full_messages.to_sentence
    end
  end
  
private
  def template_params
    params.require(:instrument_template).permit(:user_id, :template_file)
  end
  
  def parse_date(str)
    result = nil

    fields = str.split(/\//)
    if 3 == fields.length
      fmt = 2 == fields[2].length ? "%m/%d/%y" : "%m/%d/%Y"
      result = Date.strptime(str, fmt)
    end    
    
    result
  end  
end
