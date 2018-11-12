class RemoveBidAskSpreadFrom < ActiveRecord::Migration[5.2]
  def up
    remove_column :ts_composites, :bid_ask_spread
  end
  
  def down
    add_column :ts_composites, :bid_ask_spread, :decimal, :precision => 18, :scale => 6
  end
end
