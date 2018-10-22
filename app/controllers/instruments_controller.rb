class InstrumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:id_set]
      ids = []
      params[:id_set].split(",").each do |id|
        ids.push(id.to_i)
      end
      @instruments = Instrument.find(ids)
      @paginated = false
    else
      #TODO USE WILL_PAGINATE
      @instruments = Instrument.where(:approved => false).paginate(:page => params[:page])
      @paginated = true
    end
    
    render :layout => 'admin'
  end
end
