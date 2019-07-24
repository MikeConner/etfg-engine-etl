class AddAssetClassToStagingConstituents < FeedMigrationBase[5.2]
  def change
    add_column :staging_constituents, :asset_class, :string, :limit => 28
  end
end
