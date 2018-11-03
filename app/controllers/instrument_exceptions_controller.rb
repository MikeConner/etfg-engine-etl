class InstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skipped = 'true' == params[:skipped]
    @datasources = Datasource.find(InstrumentException.pending.map(&:datasource_id).uniq)
    @selected_source = params[:src_id]
        
    # Select the base list of exceptions, based on whether we're looking at skipped ones, and any datasource filter
    if @skipped
      @exceptions = @selected_source.nil? ? InstrumentException.skipped.order('score DESC, end_date DESC').limit(50) : 
        InstrumentException.skipped.where(:datasource_id => @selected_source).order('score DESC, end_date DESC').limit(50)    
      @total = @selected_source.nil? ? InstrumentException.skipped.count : 
                                       InstrumentException.skipped.where(:datasource_id => @selected_source).count               
    else
      @exceptions = @selected_source.nil? ? InstrumentException.pending.order('score DESC, end_date DESC').limit(50) : 
        InstrumentException.pending.where(:datasource_id => @selected_source).order('score DESC, end_date DESC').limit(50)                                 
      @total = @selected_source.nil? ? InstrumentException.pending.count : 
                                       InstrumentException.pending.where(:datasource_id => @selected_source).count               
    end
         
    render :layout => 'admin'
  end
  
  def reset
    @exception = InstrumentException.find(params[:id])
    @exception.update_attribute(:resolution, nil)
    
    redirect_to known_exceptions_path(:src_id => params[:src_id]), :notice => 'Instrument exception cleared'
  end
  
  def bulk_update
    params.each do |k, v|
      if k =~ /disposition_(\d+)/
        begin
          ie = InstrumentException.find($1)
          pi = ie.pooled_instrument
          # Should never be nil
          unless ie.nil?
            case v
              when InstrumentException::SKIP
                ie.update_attribute(:skipped, true)
              when InstrumentException::ACCEPT
                i = ie.instrument
                unless pi.nil?
                  i.update_attribute(:name_variants, i.name_variants + "^" + ie.candidate_name.gsub('^',' '))
                end
              when InstrumentException::EXCEPTION, InstrumentException::CORP_ACTION
                ie.update_attribute(:resolution, v)
            end
            
            if [InstrumentException::ACCEPT,InstrumentException::IGNORE].include?(v)
              ie.destroy
            end
          end
        rescue Exception => ex
          puts ex.message
        end
      end
    end
    
    redirect_to instrument_exceptions_path(:skipped => params[:skipped], :src_id => params[:source_id]), :notice => 'Exceptions updated'
  end
end
