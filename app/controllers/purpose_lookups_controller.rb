class PurposeLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = PurposeLookup.order(:account_number)
    @lookup = PurposeLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = PurposeLookup.new(purpose_params)

    if @ticker.save
      redirect_to purpose_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to purpose_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to purpose_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = PurposeLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to purpose_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def purpose_params
    params.require(:purpose_lookup).permit(:ticker, :account_number)
  end
end
