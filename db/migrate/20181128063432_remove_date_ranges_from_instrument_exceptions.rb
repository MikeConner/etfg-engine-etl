class RemoveDateRangesFromInstrumentExceptions < ActiveRecord::Migration[5.2]
  def up
    rename_column :instrument_exceptions, :start_date, :etfg_date
    remove_column :instrument_exceptions, :end_date
  end
  
  def down
   rename_column :instrument_exceptions, :etfg_date, :start_date
   add_column :instrument_exceptions, :end_date, :date    
  end
end
