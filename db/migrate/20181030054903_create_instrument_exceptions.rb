class CreateInstrumentExceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :instrument_exceptions do |t|
      t.integer :datasource_id, :null => false, :limit => 2
      t.integer :instrument_id, :null => false, :limit => 8
      t.string :candidate_name, :null => false, :limit => 128
      t.string :standard_name, :null => false, :limit => 128
      t.string :composite_ticker, :limit => 32
      t.integer :pooled_instrument_id, :limit => 8
      t.column :figi, 'character(12)'
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.date :start_date
      t.date :end_date
      t.boolean :skipped, :null => false, :default => false
      t.string :resolution, :limit => 16
      t.integer :score, :limit => 4
    end
    
    add_index :instrument_exceptions, :datasource_id
    add_index :instrument_exceptions, :instrument_id
    add_index :instrument_exceptions, :composite_ticker
    add_index :instrument_exceptions, [:datasource_id, :instrument_id, :candidate_name], :unique => true, :name => 'ie_row'    
  end
end
