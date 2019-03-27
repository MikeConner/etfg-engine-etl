class AdjustAgfLookups < FeedMigrationBase[5.2]
  def up
    remove_column :agf_lookups, :holdings_name
    remove_column :agf_lookups, :nav_name
  end
  
  def down
    add_column :agf_lookups, :fund_name, :string, :limit => 128, :null => false
    add_column :agf_lookups, :fund_number, :string, :limit => 64, :null => false
  end
end
