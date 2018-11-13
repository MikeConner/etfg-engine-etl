class RemoveBidAskSpreadFrom < ActiveRecord::Migration[5.2]
  def up
    remove_column :ts_composites, :bid_ask_spread
    remove_column :ts_composites, :open_price
    remove_column :ts_composites, :low_price
    remove_column :ts_composites, :high_price
    remove_column :ts_composites, :close_price
    remove_column :ts_composites, :daily_return
    remove_column :ts_composites, :avg_bid_size
    remove_column :ts_composites, :avg_ask_size
    remove_column :ts_composites, :avg_midpoint
    remove_column :ts_composites, :basket_estimated_cash
  end
  
  def down
    add_column :ts_composites, :bid_ask_spread, :decimal, :precision => 18, :scale => 6
    add_column :ts_composites, :open_price, :precision => 18, :scale => 6
    add_column :ts_composites, :low_price, :precision => 18, :scale => 6
    add_column :ts_composites, :high_price, :precision => 18, :scale => 6
    add_column :ts_composites, :close_price, :precision => 18, :scale => 6
    add_column :ts_composites, :daily_return, :precision => 18, :scale => 6
    add_column :ts_composites, :bid_ask_spread, :precision => 18, :scale => 6
    add_column :ts_composites, :avg_bid_size, :precision => 18, :scale => 6
    add_column :ts_composites, :avg_ask_size, :precision => 18, :scale => 6
    add_column :ts_composites, :avg_midpoint, :precision => 18, :scale => 6
    add_column :ts_composites, :basket_estimated_cash, :precision => 18, :scale => 6
  end
end
