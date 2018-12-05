class BnyLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = BnyLookup.order(:ticker)
    @lookup = BnyLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @ticker = BnyLookup.new(bny_params)

    unless params[:bny_lookup][:effective_date].blank?
      @ticker.effective_date = Date.strptime(params[:bny_lookup][:effective_date], '%m/%d/%Y')
    end
    unless params[:bny_lookup][:expiration_date].blank?
       @ticker.expiration_date = Date.strptime(params[:bny_lookup][:expiration_date], '%m/%d/%Y')
    end

    if @ticker.save
      redirect_to bny_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to bny_lookups_path, :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to bny_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end

  def update_effective_date
    @lookup = BnyLookup.find(params[:id])
    
    value = params[:effective_date].blank? ? nil : Date.strptime(params[:effective_date], '%m/%d/%Y')

    if @lookup.update_attributes(:effective_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def update_expiration_date
    @lookup = BnyLookup.find(params[:id])    

    value = params[:expiration_date].blank? ? nil : Date.strptime(params[:expiration_date], '%m/%d/%Y')

    if @lookup.update_attributes(:expiration_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def destroy
    @lookup = BnyLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to bny_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def bny_params
    params.require(:bny_lookup).permit(:fund_id, :account_name, :ticker, :effective_date, :expiration_date)
  end
end
