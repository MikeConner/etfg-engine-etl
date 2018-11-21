class AdjustInstrumentExceptions < ActiveRecord::Migration[5.2]
  def up
    remove_index :instrument_exceptions, :name => 'ie_row'
    add_index :instrument_exceptions, [:datasource_id, :instrument_id, :composite_ticker, :candidate_name], :unique => true, :name => 'ie_row'        
  end
  
  def down
    remove_index :instrument_exceptions, :name => 'ie_row'
    add_index :instrument_exceptions, [:datasource_id, :instrument_id, :candidate_name], :unique => true, :name => 'ie_row'        
  end
end
