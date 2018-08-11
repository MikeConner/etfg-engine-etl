class CreateTsComposites < ActiveRecord::Migration[5.2]
  def change
    create_table :ts_composites do |t|
      t.date :etfg_date, :null => false
      t.integer :datasource_id, :limit => 2, :null => false
      t.integer :pooled_instrument_id, :limit => 8, :null => false
      t.string :composite_ticker, :limit => 32
      t.string :composite_name, :limit => 128, :null => false
      t.decimal :aum, :precision => 18, :scale => 6
      t.decimal :shares_outstanding, :precision => 18, :scale => 6 
      t.decimal :share_value, :precision => 18, :scale => 6
      t.decimal :nav, :precision => 18, :scale => 6
      t.decimal :open_price, :precision => 18, :scale => 6
      t.decimal :low_price, :precision => 18, :scale => 6
      t.decimal :high_price, :precision => 18, :scale => 6
      t.decimal :close_price, :precision => 18, :scale => 6
      t.decimal :daily_return, :precision => 18, :scale => 6
      t.decimal :bid_ask_spread, :precision => 18, :scale => 6
      t.decimal :avg_bid_size, :precision => 18, :scale => 6
      t.decimal :avg_ask_size, :precision => 18, :scale => 6
      t.decimal :avg_midpoint, :precision => 18, :scale => 6
      t.decimal :basket_estimated_cash, :precision => 18, :scale => 6
      t.boolean :publish, :null => false, :default => false
    end
    
    add_foreign_key :ts_composites, :datasources
    add_foreign_key :ts_composites, :pooled_instruments
    
    add_index :ts_composites, :datasource_id    
    add_index :ts_composites, :etfg_date    
    add_index :ts_composites, [:etfg_date, :datasource_id]    
    add_index :ts_composites, :pooled_instrument_id
  end
end
