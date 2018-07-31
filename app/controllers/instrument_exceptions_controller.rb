class InstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @exceptions = InstrumentException.all.paginate(:page => params[:page])
    
    render :layout => 'admin'
  end
end
