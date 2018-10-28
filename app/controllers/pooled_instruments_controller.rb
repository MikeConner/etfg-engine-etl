class PooledInstrumentsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @instruments = PooledInstrument.where(:pooled_instrument_id => params[:id])
    
    render :layout => 'admin'
  end
end
