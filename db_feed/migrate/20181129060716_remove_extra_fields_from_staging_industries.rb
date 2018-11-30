class RemoveExtraFieldsFromStagingIndustries < FeedMigrationBase[5.2]
  def up
    remove_column :staging_industries, :composite_name
    remove_column :staging_industries, :avg_bid_size
    remove_column :staging_industries, :avg_ask_size
    remove_column :staging_industries, :avg_midpoint
    remove_column :staging_industries, :daily_return
    remove_column :staging_industries, :basket_estimated_cash
    change_column :staging_industries, :datasource_id, :integer, :null => true
  end
  
  def down
    add_column :staging_industries, :composite_name, :string, :limit => 128
    add_column :staging_industries, :avg_bid_size, :decimal, :precision => 22, :scale => 6
    add_column :staging_industries, :avg_ask_size, :decimal, :precision => 22, :scale => 6
    add_column :staging_industries, :avg_midpoint, :decimal, :precision => 22, :scale => 6
    add_column :staging_industries, :daily_return, :decimal, :precision => 22, :scale => 6
    add_column :staging_industries, :basket_estimated_cash, :decimal, :precision => 22, :scale => 6
    change_column :staging_industries, :datasource_id, :integer, :null => false
  end
end
