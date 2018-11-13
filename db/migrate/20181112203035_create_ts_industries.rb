class CreateTsIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :ts_industries do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.integer :datasource_id, :null => false, :limit => 2
      t.decimal :avg_daily_trading_volume, :precision => 18, :scale => 6
      t.decimal :call_volume, :precision => 18, :scale => 6
      t.decimal :discount_premium, :precision => 18, :scale => 6
      t.decimal :num_holdings, :precision => 18, :scale => 6
      t.decimal :options_volume, :precision => 18, :scale => 6
      t.decimal :put_call_ratio, :precision => 18, :scale => 6
      t.decimal :put_volume, :precision => 18, :scale => 6
      t.decimal :short_interest, :precision => 18, :scale => 6
      t.decimal :avg_bid_size, :precision => 18, :scale => 6
      t.decimal :avg_ask_size, :precision => 18, :scale => 6
      t.decimal :bid_ask_spread, :precision => 18, :scale => 6
      t.decimal :avg_midpoint, :precision => 18, :scale => 6
      t.decimal :open_price, :precision => 18, :scale => 6
      t.decimal :high_price, :precision => 18, :scale => 6
      t.decimal :low_price, :precision => 18, :scale => 6
      t.decimal :close_price, :precision => 18, :scale => 6
      t.decimal :daily_return, :precision => 18, :scale => 6
      t.decimal :basket_estimated_cash, :precision => 18, :scale => 6
      t.integer :pooled_instrument_id, :limit => 8
    end
    
    add_index :ts_industries, :etfg_date
    add_index :ts_industries, :datasource_id
    add_index :ts_industries, :pooled_instrument_id
    add_index :ts_industries, [:datasource_id, :etfg_date]
  end
end
