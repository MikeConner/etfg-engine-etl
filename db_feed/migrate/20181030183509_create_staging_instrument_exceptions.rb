class CreateStagingInstrumentExceptions < FeedMigrationBase[5.2]
  def change
    create_table :staging_instrument_exceptions do |t|
      t.integer :datasource_id, :null => false, :limit => 2
      t.integer :instrument_id, :null => false, :limit => 8
      t.string :name_in_datasource, :null => false, :limit => 128
      t.date :etfg_date, :null => false
      t.column :figi, 'character(12)'
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.string :composite_ticker, :limit => 32
      t.integer :pooled_instrument_id, :limit => 8
      t.text :trace
    end
    
    add_index :staging_instrument_exceptions, :datasource_id
    add_index :staging_instrument_exceptions, :instrument_id
    add_index :staging_instrument_exceptions, :etfg_date
  end
end
