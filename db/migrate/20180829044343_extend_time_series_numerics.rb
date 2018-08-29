class ExtendTimeSeriesNumerics < ActiveRecord::Migration[5.2]
  def up
    change_column :ts_composites, :aum, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :shares_outstanding, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :share_value, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :nav, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :open_price, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :low_price, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :high_price, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :close_price, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :daily_return, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :bid_ask_spread, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :avg_bid_size, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :avg_ask_size, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :avg_midpoint, :decimal, :precision => 22, :scale => 6
    change_column :ts_composites, :basket_estimated_cash, :decimal, :precision => 22, :scale => 6

    change_column :ts_constituents, :weight, :decimal, :precision => 22, :scale => 6
    change_column :ts_constituents, :market_value, :decimal, :precision => 22, :scale => 6
    change_column :ts_constituents, :notional_value, :decimal, :precision => 22, :scale => 6
    change_column :ts_constituents, :total_shares_held, :decimal, :precision => 22, :scale => 6
  end
  
  def down
    change_column :ts_composites, :aum, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :shares_outstanding, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :share_value, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :nav, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :open_price, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :low_price, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :high_price, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :close_price, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :daily_return, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :bid_ask_spread, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :avg_bid_size, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :avg_ask_size, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :avg_midpoint, :decimal, :precision => 18, :scale => 6
    change_column :ts_composites, :basket_estimated_cash, :decimal, :precision => 18, :scale => 6

    change_column :ts_constituents, :weight, :decimal, :precision => 18, :scale => 6
    change_column :ts_constituents, :market_value, :decimal, :precision => 18, :scale => 6
    change_column :ts_constituents, :notional_value, :decimal, :precision => 18, :scale => 6
    change_column :ts_constituents, :total_shares_held, :decimal, :precision => 18, :scale => 6    
  end
end
