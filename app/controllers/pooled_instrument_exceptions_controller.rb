class PooledInstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skipped = 'true' == params[:skipped]
    @datasources = Datasource.find(PooledInstrumentException.all.map(&:datasource_id).uniq)
    @selected_source = params[:src_id]
    # Included skipped param when we have it
    @exceptions = @selected_source.nil? ? PooledInstrumentException.order(:name_in_datasource).limit(50) : 
      PooledInstrumentException.where(:datasource_id => @selected_source).order(:name_in_datasource).limit(50)
    @total = @selected_source.nil? ? PooledInstrumentException.count : PooledInstrumentException.where(:datasource_id => @selected_source).count
    
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to pooled_instrument_exceptions_path, :notice => 'Data file updated'
  end
end
