class HorizonLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = HorizonLookup.order(:fund_ticker)
    @lookup = HorizonLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = HorizonLookup.new(horizon_params)

    if @ticker.save
      redirect_to horizon_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to horizon_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to horizon_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = HorizonLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to horizon_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def horizon_params
    params.require(:horizon_lookup).permit(:fund_ticker, :fund_name, :account)
  end
end
