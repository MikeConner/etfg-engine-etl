class DesjardinsLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = DesjardinsLookup.order(:fund_code)
    @lookup = DesjardinsLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = DesjardinsLookup.new(dj_params)

    if @ticker.save
      redirect_to desjardins_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to desjardins_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to desjardins_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = DesjardinsLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to desjardins_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def dj_params
    params.require(:desjardins_lookup).permit(:fund_code, :ticker)
  end
end
