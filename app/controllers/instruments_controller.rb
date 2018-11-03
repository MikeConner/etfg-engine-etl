class InstrumentsController < ApplicationController
  respond_to :js, :html
  
  before_action :authenticate_user!

  def index
    @paginated = false
    
    if params[:id_set]
      ids = []
      params[:id_set].split(",").each do |id|
        ids.push(id.to_i)
      end
      @instruments = Instrument.find(ids)
    elsif params[:figi]
      @instruments = Instrument.where(:figi => params[:figi])
    elsif params[:sedol]
      @instruments = Instrument.where(:sedol => params[:sedol])
    elsif params[:isin]
      @instruments = Instrument.where(:isin => params[:isin])
    elsif params[:cusip]
      @instruments = Instrument.where(:cusip => params[:cusip])
    else
      @instruments = Instrument.where(:approved => false).paginate(:page => params[:page])
      @paginated = true
    end
    
    render :layout => 'admin'
  end
  
  def set_default
    instrument = Instrument.find(params[:id])
    default_set = params[:default] == 'true'
    @instruments = Instrument.where(:instrument_id => instrument.instrument_id)

    @instruments.each do |i|
      # Should be set to the opposite
      if default_set == i.default_instrument
        raise 'Inconsistent state'
      end
    end
      
    @instruments.update_all(:default_instrument => default_set)
    
    head :ok   
  end

  def set_approved
    instrument = Instrument.find(params[:id])
    approved_set = params[:approved] == 'true'
    @instruments = Instrument.where(:instrument_id => instrument.instrument_id)

    @instruments.each do |i|
      # Should be set to the opposite
      if approved_set == i.approved
        raise 'Inconsistent state'
      end
    end
      
    @instruments.update_all(:approved => approved_set)
    
    head :ok   
  end
end
