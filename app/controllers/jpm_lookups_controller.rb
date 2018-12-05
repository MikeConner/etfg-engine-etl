class JpmLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tickers = params.has_key?(:source) ? JpmLookup.where(:source => params[:source]) : JpmLookup.order(:source, :account_number)
    @lookup = JpmLookup.new
        
    render :layout => 'admin'
  end
  
  def create
    @ticker = JpmLookup.new(jpm_params)

    unless params[:jpm_lookup][:effective_date].blank?
      @ticker.effective_date = Date.strptime(params[:jpm_lookup][:effective_date], '%m/%d/%Y')
    end
    unless params[:jpm_lookup][:expiration_date].blank?
       @ticker.expiration_date = Date.strptime(params[:jpm_lookup][:expiration_date], '%m/%d/%Y')
    end

    if @ticker.save
      redirect_to jpm_lookups_path(:source => @ticker.source), :notice => 'Lookup table entry added'
    else
      redirect_to jpm_lookups_path(:source => @ticker.source), :alert => "Error adding entry! #{@ticker.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to jpm_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end

  def update_effective_date
    @lookup = JpmLookup.find(params[:id])
    
    value = params[:effective_date].blank? ? nil : Date.strptime(params[:effective_date], '%m/%d/%Y')

    if @lookup.update_attributes(:effective_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def update_expiration_date
    @lookup = JpmLookup.find(params[:id])    

    value = params[:expiration_date].blank? ? nil : Date.strptime(params[:expiration_date], '%m/%d/%Y')

    if @lookup.update_attributes(:expiration_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def destroy
    @lookup = JpmLookup.find(params[:id])
    @lookup.destroy
    
    redirect_to jpm_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def jpm_params
    params.require(:jpm_lookup).permit(:source, :account_number, :account_name, :ticker)
  end
end
