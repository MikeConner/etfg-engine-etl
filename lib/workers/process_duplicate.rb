class ProcessDuplicate < ProgressJob::Base
  def initialize(old_instrument_id, new_instrument_id)
    @old_id = old_instrument_id
    @new_id = new_instrument_id
  end

  def perform
    constituent_name = Instrument.find(@new_id).standard_name
    TsConstituent.where(:instrument_id => @old_id).update_all(:instrument_id => @new_id, :constituent_name => constituent_name)
    InstrumentException.where(:instrument_id => @old_id).update_all(:instrument_id => @new_id)
    StagingInstrumentException.where(:instrument_id => @old_id).update_all(:instrument_id => @new_id)
    # Staging basket constituents, ts_basket_constituents
    ['feed.staging_basket_constituents', 'ts_basket_constituents'].each do |table|
       sql = "UPDATE #{table} SET instrument_id=#{@new_id} WHERE instrument_id=#{@old_id}"
       ActiveRecord::Base.connection.execute(sql)
    end
    
  rescue Exception => ex
    puts ex.message
  end
end
