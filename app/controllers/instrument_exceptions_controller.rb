class InstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skipped = 'true' == params[:skipped]
    @total = InstrumentException.count
    # Included skipped param when we have it
    @exceptions = InstrumentException.order(:name_in_datasource).limit(50)
    
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to instrument_exceptions_path, :notice => 'Data file updated'
  end
end
