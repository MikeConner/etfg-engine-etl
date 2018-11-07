class AmbiguousInstrumentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @selected_source = params[:src_id]
    @exceptions = @selected_source.nil? ? AmbiguousInstrument.order('file_date DESC').limit(50) : 
                    AmbiguousInstrument.where(:datasource_id => @selected_source).order('file_date DESC').limit(50)
     
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to ambiguous_instruments_path, :notice => 'Data file updated'
  end
end
