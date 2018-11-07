class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def workbench
    @dags = DagStatus.running.order('updated_at DESC')
    
    render :layout => 'admin'
  end
  
  def lookups
    render :layout => 'admin'
  end
  
  def templates
    @instrument_template = InstrumentTemplate.new
    
    render :layout => 'admin'
  end
end
