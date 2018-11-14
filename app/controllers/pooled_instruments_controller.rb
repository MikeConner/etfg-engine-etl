class PooledInstrumentsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @instruments = PooledInstrument.where(:pooled_instrument_id => params[:id]).order(:standard_composite_name)
    
    render :layout => 'admin'
  end
end
