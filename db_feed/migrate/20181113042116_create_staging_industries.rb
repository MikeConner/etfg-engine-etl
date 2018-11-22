class CreateStagingIndustries < FeedMigrationBase[5.2]
  def change
    create_table :staging_industries do |t|
      t.date :etfg_date, :null => false
      t.date :as_of_date, :null => false
      t.integer :datasource_id, :null => false
      t.string :composite_ticker, :null => false, :limit => 32
      t.string :composite_name, :limit => 128
      t.string :country, :limit => 64, :null => false, :default => 'US'
      t.decimal :avg_daily_trading_volume, :precision => 22, :scale => 6
      t.decimal :call_volume, :precision => 22, :scale => 6
      t.decimal :discount_premium, :precision => 22, :scale => 6
      t.decimal :num_holdings, :precision => 22, :scale => 6
      t.decimal :options_volume, :precision => 22, :scale => 6
      t.decimal :put_call_ratio, :precision => 22, :scale => 6
      t.decimal :put_volume, :precision => 22, :scale => 6
      t.decimal :short_interest, :precision => 22, :scale => 6
      t.decimal :bid_ask_spread, :precision => 22, :scale => 6
      t.decimal :avg_bid_size, :precision => 22, :scale => 6
      t.decimal :avg_ask_size, :precision => 22, :scale => 6
      t.decimal :bid_ask_spread, :precision => 22, :scale => 6
      t.decimal :avg_midpoint, :precision => 22, :scale => 6
      t.decimal :open_price, :precision => 22, :scale => 6
      t.decimal :high_price, :precision => 22, :scale => 6
      t.decimal :low_price, :precision => 22, :scale => 6
      t.decimal :close_price, :precision => 22, :scale => 6
      t.decimal :daily_return, :precision => 22, :scale => 6
      t.decimal :basket_estimated_cash, :precision => 22, :scale => 6
      t.integer :pooled_instrument_id
      t.boolean :match, :null => false, :default => false
    end
    
    add_index :staging_industries, :etfg_date
    add_index :staging_industries, :datasource_id
    add_index :staging_industries, :pooled_instrument_id
    add_index :staging_industries, [:datasource_id, :etfg_date]
  end
end
