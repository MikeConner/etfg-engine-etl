class CreateStagingConstituents < FeedMigrationBase[5.2]
  def change
    create_table :staging_constituents do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.integer :datasource_id, :null => false
      t.integer :pooled_instrument_id, :limit => 8
      t.integer :instrument_id, :limit => 8
      t.string :composite_ticker, :limit => 32
      t.string :composite_name, :limit => 128
      t.string :constituent_ticker, :limit => 64
      t.string :constituent_name, :limit => 128
      t.decimal :weight, :precision => 18, :scale => 6
      t.decimal :market_value, :precision => 18, :scale => 6
      t.decimal :notional_value, :precision => 18, :scale => 6
      t.decimal :total_shares_held, :precision => 18, :scale => 6
      t.integer :issuer_id
      t.string :issuer, :limit => 32
      t.column :figi, 'character(12)'
      t.boolean :is_exchange_figi
      t.column :sedol, 'character(7)'
      t.column :isin, 'character(12)'
      t.column :cusip, 'character(9)'
      t.string :exchange_country, :limit => 64
      t.string :currency, :limit => 16
      t.string :exchange, :limit => 64
      t.string :market_sector, :limit => 128
      t.string :security_type, :limit => 128
      t.string :sector, :limit => 64
      t.string :industry, :limit => 64
      t.string :industry_group, :limit => 128
      t.string :subindustry, :limit => 128
      t.string :rating, :limit => 32
    end
    
    # These don't work cross-schema, at least not in migrations
    #add_foreign_key :staging_constituents, :datasources
    #add_foreign_key :staging_constituents, :pooled_instruments
    #add_foreign_key :staging_constituents, :instruments
    
    add_index :staging_constituents, [:etfg_date, :datasource_id]
    add_index :staging_constituents, [:as_of_date, :datasource_id]
    add_index :staging_constituents, :composite_ticker
    add_index :staging_constituents, [:composite_ticker, :exchange_country], :name => 'ticker_country_constituents'  
    add_index :staging_constituents, :figi
  end
end
