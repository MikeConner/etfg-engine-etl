class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def workbench
    @dags = DagStatus.running.order('updated_at DESC')
    sql = 'SELECT etfg_date,datasource_id,COUNT(*) FROM feed.staging_constituents ' + 
          "WHERE composite_ticker IS NULL AND etfg_date >= '" + 3.days.ago.try(:strftime, '%m/%d/%Y') +
          "' GROUP BY etfg_date, datasource_id ORDER BY datasource_id,etfg_date DESC"
    @null_tickers = ActiveRecord::Base.connection.execute(sql)
    @source_map = Hash.new
    Datasource.all.each do |ds|
      @source_map[ds.id] = ds.data_source_name
    end
    
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
