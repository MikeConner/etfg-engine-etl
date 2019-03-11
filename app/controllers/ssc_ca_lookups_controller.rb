class SscCaLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = SscCaLookup.order(:code)
    @lookup = SscCaLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = SscCaLookup.new(ssc_ca_params)

    if @ticker.save
      redirect_to ssc_ca_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to ssc_ca_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to ssc_ca_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = SscCaLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to ssc_ca_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def ssc_ca_params
    params.require(:ssc_ca_lookup).permit(:code, :ticker, :fund_name)
  end
end
