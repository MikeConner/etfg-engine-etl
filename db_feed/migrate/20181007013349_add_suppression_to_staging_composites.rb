class AddSuppressionToStagingComposites < FeedMigrationBase[5.2]
  def change
    add_column :staging_composites, :exclude_from_ts, :boolean, :null => false, :default => false
    add_column :staging_constituents, :exclude_from_ts, :boolean, :null => false, :default => false
  end
end
