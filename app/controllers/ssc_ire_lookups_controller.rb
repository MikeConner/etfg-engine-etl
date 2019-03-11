class SscIreLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = SscIreLookup.order(:code)
    @lookup = SscIreLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = SscIreLookup.new(ssc_ire_params)

    if @ticker.save
      redirect_to ssc_ire_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to ssc_ire_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to ssc_ire_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = SscIreLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to ssc_ire_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def ssc_ire_params
    params.require(:ssc_ire_lookup).permit(:code, :ticker, :fund_name)
  end
end
