class InstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skipped = 'true' == params[:skipped]
    @datasources = Datasource.find(InstrumentException.all.map(&:datasource_id).uniq)
    @selected_source = params[:src_id]
        
    # Select the base list of exceptions, based on whether we're looking at skipped ones, and any datasource filter
    if @skipped
      @exceptions = @selected_source.nil? ? InstrumentException.skipped.order('score DESC, end_date DESC').limit(50) : 
        InstrumentException.skipped.where(:datasource_id => @selected_source).order('score DESC, end_date DESC').limit(50)                           
    else
      @exceptions = @selected_source.nil? ? InstrumentException.order('score DESC, end_date DESC').limit(50) : 
        InstrumentException.where(:datasource_id => @selected_source).order('score DESC, end_date DESC').limit(50)                                 
    end
     
    @total = @exceptions.count
    
    render :layout => 'admin'
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
                  i.update_attribute(:name_variants, i.name_variants + "^" + ie.name_in_datasource.gsub('^',' '))
                end
              when InstrumentException::EXCEPTION
              when InstrumentException::CORP_ACTION
                ie.update_attribute(:resolution, v)
            end
            
            if [InstrumentException::ACCEPT,InstrumentException::IGNORE].include?(v)
              InstrumentException.where(:instrument_id => ie.instrument_id, 
                                        :name_in_datasource => ie.name_in_datasource,
                                        :datasource_id => ie.datasource_id,
                                        :skipped => false).destroy_all
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
