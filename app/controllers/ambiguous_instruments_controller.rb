class AmbiguousInstrumentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @exceptions = AmbiguousInstrument.order('file_date DESC')
     
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to ambiguous_instruments_path, :notice => 'Data file updated'
  end
end
