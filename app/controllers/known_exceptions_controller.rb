class KnownExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @selected_source = params[:src_id]
    @datasources = Datasource.where('id IN (?) ', KnownException.pluck(:datasource_id).uniq + 
                                                  InstrumentException.where(:resolution => InstrumentException::EXCEPTION).map(&:datasource_id))
    @exceptions = @selected_source.blank? ? KnownException.order('datasource_id DESC, constituent_name') : 
                                            KnownException.where(:datasource_id => @selected_source).order(:constituent_name)

    @pending = @selected_source.blank? ? InstrumentException.where(:resolution => InstrumentException::EXCEPTION).order(:candidate_name) : 
                                         InstrumentException.where(:resolution => InstrumentException::EXCEPTION,
                                                                   :datasource_id => @selected_source).order(:candidate_name)
    render :layout => 'admin'
  end
  
  def new
    @ie_base = InstrumentException.find(params[:ie_id])
    @exception = KnownException.new(:datasource_id => @ie_base.datasource_id, :constituent_name => @ie_base.candidate_name)

    render :layout => 'admin'
  end
  
  def create
    # We are creating one or more exceptions, based on whether the cb_cusip/cb_figi, etc. checkboxes are set
    # If they are set, set id_type and id_value to ie_cusip/figi/etc.
    @exceptions = []
    @ie_base = InstrumentException.find(params[:ie_id])
    
    if '1' == params[:cb_figi]
      @exceptions.push(create_exception('figi', params[:ie_figi]))
    end
    if '1' == params[:cb_sedol]
      @exceptions.push(create_exception('sedol', params[:ie_sedol]))
    end
    if '1' == params[:cb_isin]
      @exceptions.push(create_exception('isin', params[:ie_isin]))
    end
    if '1' == params[:cb_cusip]
      @exceptions.push(create_exception('cusip', params[:ie_cusip]))
    end
    
    valid_exceptions = 0
    @exceptions.each do |e|
      valid_exceptions += 1 if e.valid? and (!e.figi.blank? or !e.sedol.blank? or !e.isin.blank? or !e.cusip.blank?)
    end

    if 0 == valid_exceptions
      @exception = KnownException.new(:datasource_id => @ie_base.datasource_id, :constituent_name => @ie_base.candidate_name)
      flash.now[:alert] = 'No valid exceptions to create - please choose at least one identifier!'
      render 'new', :layout => 'admin' 
    else
      begin
        ActiveRecord::Base.transaction do
          @exceptions.each do |e|
            e.save!
          end
          @ie_base.destroy
        end
        
        redirect_to known_exceptions_path, :notice => 'Known exception(s) created'
      rescue Exception => ex        
        @exception = KnownException.new(:datasource_id => @ie_base.datasource_id, :constituent_name => @ie_base.candidate_name)
        flash.now[:alert] = "Known exception errors: #{ex.message}"
        render 'new', :layout => 'admin'
      end 
    end  
  end
  
  def bulk_update
    puts params
    
    redirect_to known_exceptions_path, :notice => 'Data file updated'
  end

private
  def create_exception(id_type, id_value)
    @exception = KnownException.new(exception_params)
    @exception.id_type = id_type
    @exception.id_value = id_value
    
    @exception  
  end
  
  def exception_params
    params.require(:known_exception).permit(:datasource_id, :constituent_name, :country, :currency, :figi, :sedol, :isin, :cusip)
  end  
end
