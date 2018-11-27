class InstrumentExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @corp_actions = 'true' == params[:corporate_actions]
    @ticker = params[:ticker]
    if @corp_actions
      @datasources = Datasource.find(InstrumentException.corporate.map(&:datasource_id).uniq)
      @selected_source = params[:src_id] unless 0 == params[:src_id].to_i
      
      @base = InstrumentException.corporate
      unless @selected_source.blank?
        @base = @base.where(:datasource_id => @selected_source)
      end
      unless @ticker.blank?
        @base = @base.where(:composite_ticker => @ticker)
      end    
    else  
      @skipped = 'true' == params[:skipped]
      @datasources = Datasource.find(InstrumentException.pending.map(&:datasource_id).uniq)
      @selected_source = params[:src_id] unless 0 == params[:src_id].to_i
          
      # Select the base list of exceptions, based on whether we're looking at skipped ones, and any datasource filter
      @base = @skipped ? InstrumentException.skipped : InstrumentException.pending
      unless @selected_source.blank?
        @base = @base.where(:datasource_id => @selected_source)
      end
      unless @ticker.blank?
        @base = @base.where(:composite_ticker => @ticker)
      end      
    end
    
    @total = @base.count
    @exceptions = @base.order('score DESC, end_date DESC').limit(50)        
         
    render :layout => 'admin'
  end
  
  def reset
    @exception = InstrumentException.find(params[:id])
    @exception.update_attribute(:resolution, nil)
    
    if params[:corporate]
      redirect_to instrument_exceptions_path(:src_id => params[:src_id], :corporate_actions => true), :notice => 'Instrument exception cleared'
    else
      redirect_to known_exceptions_path(:src_id => params[:src_id]), :notice => 'Instrument exception cleared'
    end
  end
  
  def split
    @exception = InstrumentException.find(params[:id])
    # Split the instrument into two
    split_date = Date.strptime(params[:date], "%m/%d/%Y")
    first_instrument = @exception.instrument
    second_instrument = first_instrument.dup
    new_name = params[:name] || @exception.candidate_name.strip
    
    # Set fields on first
    first_instrument.expiration_date = split_date
    second_instrument.assign_attributes(:effective_date => split_date,
                                        :standard_name => new_name,
                                        :name_variants => new_name,
                                        :notes => "Split from #{first_instrument.id}",
                                        :default_instrument => false,
                                        :datasource_id => @exception.datasource_id)    
    # Throw exception on failure
    ensure_valid_instruments(first_instrument, second_instrument)
    ActiveRecord::Base.transaction do
      first_instrument.save!
      second_instrument.save!
      @exception.destroy
    end
      
    # Show all instrument with this id
    id_set = Instrument.where(:instrument_id => first_instrument.instrument_id).map(&:id).join(",")
    redirect_to instruments_path(:id_set => id_set), :notice => 'Instrument split successfully'  
  rescue Exception => ex    
    redirect_to instrument_exceptions_path(:src_id => params[:src_id], :corporate_actions => true), :alert => "Error splitting instrument: #{ex.message}"
  end
  
  def bulk_update
    params.each do |k, v|
      if k =~ /standard_name_(\d+)/
        begin
          ie = InstrumentException.find($1)
          i = ie.instrument
          if v != ie.standard_name and !v.blank?
            i.update_attribute(:standard_name, v)
          end
        rescue Exception => ex
          puts ex.message
        end
      elsif k =~ /disposition_(\d+)/
        begin
          ie = InstrumentException.find($1)
          pi = ie.pooled_instrument
          # Should never be nil
          unless ie.nil?
            case v
              when InstrumentException::SKIP
                ie.update_attribute(:skipped, true)
              when InstrumentException::ACCEPT, InstrumentException::ACCEPT_AS_STANDARD
                i = ie.instrument
                unless pi.nil?
                  candidate_name = ie.candidate_name.gsub('^',' ')
                  i.update_attribute(:name_variants, i.name_variants + "^" + candidate_name)
                  if InstrumentException::ACCEPT_AS_STANDARD == v
                    i.update_attribute(:standard_name, candidate_name)
                  end
                end
              when InstrumentException::EXCEPTION, InstrumentException::CORP_ACTION
                ie.update_attribute(:resolution, v)
            end
            
            if [InstrumentException::ACCEPT,InstrumentException::ACCEPT_AS_STANDARD,InstrumentException::IGNORE].include?(v)
              ie.destroy
            end
          end
        rescue Exception => ex
          puts ex.message
        end
      end
    end
    
    redirect_to instrument_exceptions_path(:skipped => params[:skipped], :src_id => params[:source_id]), :notice => 'Exceptions updated'
  end
  
private
  def ensure_valid_instruments(i1, i2)
    caveman = Date.strptime('1/1/1900', '%m/%d/%Y')
    jetsons = Date.strptime('1/1/2300', '%m/%d/%Y')
    # Should find i1, plus any other pre-existing ones
    records = Instrument.where(:instrument_id => i1.instrument_id)
    found_i1 = false
    ranges = []
    records.each do |r|
      if r.id == i1.id
        found_i1 = true
      end
      ranges.push((r.effective_date || caveman)..(r.expiration_date || jetsons))
    end
    
    unless found_i1
      raise 'Not not find original exception in db!'
    end
    ranges.push((i2.effective_date || caveman)..(i2.expiration_date || jetsons))
    
    valid = true
    error_msg = nil
    
    # We now have a set of ranges
    (1..(ranges.count - 2)).each do |i|
      (i + 1..(ranges.count - 1)).each do |j|
        if ranges[i].overlaps?(ranges[j])    
          valid = false
          error_msg = ranges[i].to_s + ":" + ranges[j].to_s
          break  
        end
      end
    end
    
    unless valid
      raise 'Date range overlap! #{error_msg}'
    end
  end
end
