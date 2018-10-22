class PooledInstrumentsController < ApplicationController
  respond_to :js
  
  before_action :authenticate_user!
  
  def update_name
    @pi = PooledInstrument.find(params[:id])
    
    unless params[:name].blank?
      @pi.update_attribute(:standard_composite_name, params[:name])
    end
    
    head :ok
  end
end
