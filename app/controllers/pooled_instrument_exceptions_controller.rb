class PooledInstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skipped = 'true' == params[:skipped]
    @datasources = Datasource.find(PooledInstrumentException.all.map(&:datasource_id).uniq)
    @selected_source = params[:src_id]
    
    # Select the base list of exceptions, based on whether we're looking at skipped ones, and any datasource filter
    base_exceptions = @skipped ? PooledInstrumentException.skipped.order(:name_in_datasource, :file_date) : 
                                 PooledInstrumentException.order(:name_in_datasource, :file_date)
    unless @selected_source.nil?
      base_exceptions = base_exceptions.where(:datasource_id => @selected_source)
    end
    # Simple list of exceptions to display
    @exceptions = []
    # Map of instrument id to dates (earliest - latest)
    @date_map = Hash.new
    base_exceptions.group_by { |e| e.pooled_instrument_id }.each do |pid, ex_list|
      break if @exceptions.count >= 50
      
      if 1 == ex_list.count
        @exceptions.push(ex_list[0])
      else
        name = nil
        dates = nil
        id = nil
        root = nil
        
        ex_list.each do |ex|
          if name.nil? or ex.name_in_datasource != name
            unless id.nil?
              # Add the old one; this is a new name value in the list
              @date_map[id] = dates
              @exceptions.push(root)
            end
            name = ex.name_in_datasource
            dates = [ex.file_date, ex.file_date]
            id = ex.id
            root = ex
          else
            dates[0] = ex.file_date if ex.file_date < dates[0]
            dates[1] = ex.file_date if ex.file_date > dates[1]
          end
        end
        
        @date_map[id] = dates
        @exceptions.push(root)        
      end
    end
    
    @total = @skipped ? @exceptions.count : base_exceptions.count
    
    render :layout => 'admin'
  end
  
  def bulk_update
    params.each do |k, v|
      if k =~ /disposition_(\d+)/
        begin
          pe = PooledInstrumentException.find($1)
          # Should never be nil
          unless pe.nil?
            case v
              when 'Skip'
                pe.update_attribute(:skipped, true)
              when 'Accept'
                pi = pe.pooled_instrument
                unless pi.nil?
                  pi.update_attribute(:composite_name_variants, pi.composite_name_variants + "^" + pe.name_in_datasource.gsub('^',' '))
                end
            end
            # Delete it (and all the duplicates!) unless we're skipping
            unless 'Skip' == v
              PooledInstrumentException.where(:pooled_instrument_id => pe.pooled_instrument_id, 
                                              :name_in_datasource => pe.name_in_datasource,
                                              :datasource_id => pe.datasource_id,
                                              :skipped => false).destroy_all
            end
          end
        rescue Exception => ex
          puts ex.message
        end
      end
    end
    
    redirect_to pooled_instrument_exceptions_path(:skipped => params[:skipped], :src_id => params[:source_id]), :notice => 'Exceptions updated'
  end
end
