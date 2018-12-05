class DateAdjustFundFlowsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = params.has_key?(:ticker) ? 
      DateAdjustFundFlow.where(:composite_ticker => params[:ticker]) : DateAdjustFundFlow.order(:composite_ticker)
    @adjust = DateAdjustFundFlow.new
        
    render :layout => 'admin'
  end
  
  def create
    @adjust = DateAdjustFundFlow.new(ff_params)
    unless params[:date_adjust_fund_flow][:effective_date].blank?
      @adjust.effective_date = Date.strptime(params[:date_adjust_fund_flow][:effective_date], '%m/%d/%Y')
    end
    unless params[:date_adjust_fund_flow][:expiration_date].blank?
      @adjust.expiration_date = Date.strptime(params[:date_adjust_fund_flow][:expiration_date], '%m/%d/%Y')
    end
    
    if @adjust.save
      redirect_to date_adjust_fund_flows_path, :notice => 'Fund Flow table entry added'
    else
      redirect_to date_adjust_fund_flows_path, :alert => "Error adding entry! #{@adjust.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to date_adjust_fund_flows_path, :alert => "Error adding entry! #{ex.message}"     
  end

  def update_effective_date
    @adjust = DateAdjustFundFlow.find(params[:id])
    
    value = params[:effective_date].blank? ? nil : Date.strptime(params[:effective_date], '%m/%d/%Y')

    if @adjust.update_attribute(:effective_date, value)
      head :ok
    else
      render :text => @adjust.errors.full_messages.to_sentence
    end
  end
  
  def update_expiration_date
    @adjust = DateAdjustFundFlow.find(params[:id])    

    value = params[:expiration_date].blank? ? nil : Date.strptime(params[:expiration_date], '%m/%d/%Y')

    if @adjust.update_attribute(:expiration_date, value)
      head :ok
    else
      render :text => @adjust.errors.full_messages.to_sentence
    end
  end
  
  def destroy
    @adjust = DateAdjustFundFlow.find(params[:id])
    @adjust.destroy
    
    redirect_to date_adjust_fund_flows_path, :notice => 'Fund Flow entry deleted'
  end
  
private
  def ff_params
    params.require(:date_adjust_fund_flow).permit(:composite_ticker, :effective_date, :expiration_date)
  end
end
