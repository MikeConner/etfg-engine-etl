class ExtendStagingNumerics < FeedMigrationBase[5.2]
  def up
    change_column :staging_composites, :aum, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :shares_outstanding, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :share_value, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :nav, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :open_price, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :low_price, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :high_price, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :close_price, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :daily_return, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :bid_ask_spread, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :avg_bid_size, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :avg_ask_size, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :avg_midpoint, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :basket_estimated_cash, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :net_expenses, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :expense_ratio, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :total_expenses, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :other_expenses, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :levered_amount, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :fee_waivers, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :creation_fee, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :creation_unit_size, :decimal, :precision => 22, :scale => 6
    change_column :staging_composites, :management_fee, :decimal, :precision => 22, :scale => 6

    change_column :staging_constituents, :weight, :decimal, :precision => 22, :scale => 6
    change_column :staging_constituents, :market_value, :decimal, :precision => 22, :scale => 6
    change_column :staging_constituents, :notional_value, :decimal, :precision => 22, :scale => 6
    change_column :staging_constituents, :total_shares_held, :decimal, :precision => 22, :scale => 6
  end
  
  def down
    change_column :staging_composites, :aum, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :shares_outstanding, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :share_value, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :nav, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :open_price, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :low_price, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :high_price, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :close_price, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :daily_return, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :bid_ask_spread, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :avg_bid_size, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :avg_ask_size, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :avg_midpoint, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :basket_estimated_cash, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :net_expenses, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :expense_ratio, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :total_expenses, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :other_expenses, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :levered_amount, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :fee_waivers, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :creation_fee, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :creation_unit_size, :decimal, :precision => 18, :scale => 6
    change_column :staging_composites, :management_fee, :decimal, :precision => 18, :scale => 6

    change_column :staging_constituents, :weight, :decimal, :precision => 18, :scale => 6
    change_column :staging_constituents, :market_value, :decimal, :precision => 18, :scale => 6
    change_column :staging_constituents, :notional_value, :decimal, :precision => 18, :scale => 6
    change_column :staging_constituents, :total_shares_held, :decimal, :precision => 18, :scale => 6    
  end
end
