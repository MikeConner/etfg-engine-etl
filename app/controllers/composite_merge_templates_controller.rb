require 'csv'

class CompositeMergeTemplatesController < ApplicationController
  before_action :authenticate_user!

  def create
    @template = CompositeMergeTemplate.new(template_params)
    ok = @template.save
    if ok
      if @template.template_file.file.nil?
        @template.errors.add(:base, "Composite merge template file invalid") 
        ok = false
      end
    end

    if ok
      # Need to clean up non-ASCII characters
      perl_output = `perl -pi -e 's/[^[:ascii:]]//g' #{@template.template_file.file.path}`
      puts perl_output
      
      today = Date.today
      
      csv_result = 'old_pooled_instrument_id,new_pooled_instrument_id,change_date,result\n'
      
      # Read the file and set it
      CSV.foreach(@template.template_file.file.path, :headers => true) do |row|
        # Reject blank lines
        next if row[0].blank?

        csv_result += "#{row[0]},#{row[1]},#{row[2]},"
        
        begin
          old_pooled_instrument = PooledInstrument.find(row[0].to_i) rescue nil
          new_pooled_instrument = PooledInstrument.find(row[1].to_i) rescue nil
          change_date = parse_date(row[2]) rescue today
          
          if old_pooled_instrument.nil? or new_pooled_instrument.nil?
            csv_result += "Could not find pooled instruments\n"
          else
            old_id = old_pooled_instrument.id
            new_id = new_pooled_instrument.id
            # Ensure dates work
            # Going to set expiration date of old one to change_date
            
            # and effective_date of new_instrument to change_date
            if new_pooled_instrument.expiration_date.nil? or change_date < new_pooled_instrument.expiration_date
              # Dates are ok - make change
              ActiveRecord::Base.transaction do
                # Effective_date could be wrong - if it's after the expiration date, set it to null
                if old_pooled_instrument.effective_date.nil? or change_date > old_pooled_instrument.effective_date
                  old_pooled_instrument.update_attribute!(:expiration_date => change_date)
                else
                  old_pooled_instrument.update_attributes!(:effective_date => nil, 
                                                           :expiration_date => change_date)
                end
                
                new_pooled_instrument.update_attributes!(:effective_date => change_date, 
                                                         :pooled_instrument_id => old_pooled_instrument.id)
                                                         
                # Now update all tables that have pooled_instrument_id
                ['feed.staging_basket_composites', 'feed.staging_basket_constituents', 
                 'feed.staging_composites', 'feed.staging_constituents',
                 'feed.staging_industries', 'feed.staging_instrument_exceptions',
                 'instrument_exceptions', 'pooled_instrument_exceptions', 
                 'ts_basket_composites', 'ts_basket_constituents', 'ts_basket_exposures', 'ts_baskets',
                 'ts_composites', 'ts_constituents', 'ts_exposures', 'ts_industries'].each do |table|
                   
                   sql = "UPDATE #{table} SET pooled_instrument_id=#{old_id} WHERE pooled_instrument_id=#{new_id}"
                   ActiveRecord::Base.connection.execute(sql)
                 end
              end
              csv_result += "Success\n"
            else
              csv_result += "Change date incompatible with expiration_date of new instrument\n"                              
            end
          end
        rescue Exception => ex
          csv_result += "Exception: #{ex.message}\n"
        end
      end
            
      #redirect_to root_path, :notice => "ETPR template file uploaded (#{stats})"
      send_data csv_result,
                :filename => "Composite Merge Template Result.csv",
                :type => "text/csv",
                :disposition => 'attachment'
    else
      redirect_to templates_path, :alert => @template.errors.full_messages.to_sentence
    end
  end
  
private
  def parse_boolean(val)
    return val.blank? ? false : ['y','yes','t','true','1'].include?(val.downcase)
  end
  
  def parse_date(str)
    result = nil

    fields = str.split(/\//) rescue []
    if 3 == fields.length
      fmt = 2 == fields[2].length ? "%m/%d/%y" : "%m/%d/%Y"
      result = Date.strptime(str, fmt)
    else
      fields = str.split(/-/) rescue []
      fmt = 2 == fields[0].length ? "%y-%m-%d" : "%Y-%m-%d"
      result = Date.strptime(str, fmt)
    end    
    
    result
  end
  
  def template_params
    params.require(:composite_merge_template).permit(:user_id, :template_file)
  end
end
