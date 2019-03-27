class AgfLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = AgfLookup.order(:ticker)
    @lookup = AgfLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = AgfLookup.new(agf_params)

    if @ticker.save
      redirect_to agf_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to agf_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to agf_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = AgfLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to agf_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def agf_params
    params.require(:agf_lookup).permit(:ticker, :fund_number)
  end
end
