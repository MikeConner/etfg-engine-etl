class FirstAssetFundsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = FirstAssetFund.order(:ticker)
    @lookup = FirstAssetFund.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = FirstAssetFund.new(first_asset_params)

    if @ticker.save
      redirect_to first_asset_funds_path, :notice => 'Lookup table entry added'
    else
      redirect_to first_asset_funds_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to first_asset_funds_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @lookup = FirstAssetFund.find(params[:id])
    @lookup.destroy
    
    redirect_to first_asset_funds_path, :notice => 'Lookup entry deleted'
  end
  
private
  def first_asset_params
    params.require(:first_asset_fund).permit(:ticker, :fund_name, :address)
  end
end
