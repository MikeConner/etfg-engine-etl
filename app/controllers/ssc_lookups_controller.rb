class SscLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = SscLookup.order(:fund_id).paginate(:page => params[:page])
    @lookup = SscLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = SscLookup.new(ssc_add_params)
    if @ticker.save
      redirect_to ssc_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to ssc_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to ssc_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def update_effective_date
    @lookup = SscLookup.find(params[:id])
    
    value = params[:effective_date].blank? ? nil : Date.strptime(params[:effective_date], '%m/%d/%Y')

    if @lookup.update_attributes(:effective_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def update_expiration_date
    @lookup = SscLookup.find(params[:id])    

    value = params[:expiration_date].blank? ? nil : Date.strptime(params[:expiration_date], '%m/%d/%Y')

    if @lookup.update_attributes(:expiration_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def destroy
    @lookup = SscLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to ssc_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def ssc_add_params
    params.require(:ssc_lookup).permit(:fund_id, :fund_name, :ticker, :effective_date, :expiration_date, :fund_id_alias)
  end
end
