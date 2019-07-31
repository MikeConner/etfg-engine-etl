class LengthenAssetClass < FeedMigrationBase[5.2]
  def up
    change_column :staging_constituents, :asset_class, :string, :limit => 64   
  end
  
  def down
    change_column :staging_constituents, :asset_class, :string, :limit => 28    
  end
end
