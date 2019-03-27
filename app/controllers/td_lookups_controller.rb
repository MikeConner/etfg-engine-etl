class TdLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = TdLookup.order(:account_number)
    @lookup = TdLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = TdLookup.new(td_params)

    if @ticker.save
      redirect_to td_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to td_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to td_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = TdLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to td_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def td_params
    params.require(:td_lookup).permit(:ticker, :account_number)
  end
end
