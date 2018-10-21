class AddSegmentToStagingConstituents < FeedMigrationBase[5.2]
  def change
    add_column :staging_constituents, :segment, :integer, :limit => 2
  end
end
