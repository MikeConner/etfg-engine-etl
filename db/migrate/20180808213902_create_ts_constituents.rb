class CreateTsConstituents < ActiveRecord::Migration[5.2]
  def change
    create_table :ts_constituents do |t|
      t.date :etfg_date, :null => false
      t.integer :datasource_id, :limit => 2, :null => false
      t.integer :pooled_instrument_id, :limit => 8, :null => false
      t.integer :instrument_id, :limit => 8, :null => false
      t.string :composite_ticker, :limit => 32
      t.string :composite_name, :limit => 128, :null => false
      t.string :constituent_ticker, :limit => 64
      t.string :constituent_name, :limit => 128, :null => false
      t.decimal :weight, :precision => 18, :scale => 6
      t.decimal :market_value, :precision => 18, :scale => 6
      t.decimal :notional_value, :precision => 18, :scale => 6
      t.decimal :total_shares_held, :precision => 18, :scale => 6
      t.boolean :publish, :null => false, :default => false
    end
    
    add_foreign_key :ts_constituents, :datasources
    add_foreign_key :ts_constituents, :pooled_instruments
    add_foreign_key :ts_constituents, :instruments
    
    add_index :ts_constituents, :datasource_id    
    add_index :ts_constituents, :etfg_date    
    add_index :ts_constituents, [:etfg_date, :datasource_id]    
    add_index :ts_constituents, :pooled_instrument_id
    add_index :ts_constituents, :instrument_id
  end
end
