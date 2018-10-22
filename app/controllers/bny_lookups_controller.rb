class BnyLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = BnyLookup.order(:ticker)
    @lookup = BnyLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = BnyLookup.new(bny_params)
    if @ticker.save
      redirect_to bny_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to bny_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to bny_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = BnyLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to bny_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def bny_params
    params.require(:bny_lookup).permit(:fund_id, :account_name, :ticker)
  end
end
