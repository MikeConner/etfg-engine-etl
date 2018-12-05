class AddExcludeFromTsToStagingIndustries < FeedMigrationBase[5.2]
  def change
    add_column :staging_industries, :exclude_from_ts, :boolean, :null => false, :default => false
  end
end
