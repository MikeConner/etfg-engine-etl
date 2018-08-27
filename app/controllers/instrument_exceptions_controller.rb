class InstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skipped = 'true' == params[:skipped]
    @datasources = Datasource.find(InstrumentException.all.map(&:datasource_id).uniq)
    @selected_source = params[:src_id]
    # Included skipped param when we have it
    @exceptions = @selected_source.nil? ? InstrumentException.order(:name_in_datasource).limit(50) : 
      InstrumentException.where(:datasource_id => @selected_source).order(:name_in_datasource).limit(50)
    @total = @selected_source.nil? ? InstrumentException.count : InstrumentException.where(:datasource_id => @selected_source).count
    
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to instrument_exceptions_path, :notice => 'Data file updated'
  end
end
