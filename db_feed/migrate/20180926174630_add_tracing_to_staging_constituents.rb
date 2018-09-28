class AddTracingToStagingConstituents < FeedMigrationBase[5.2]
  def change
    add_column :staging_constituents, :disposition, :string, :limit => 32
    add_column :staging_constituents, :trace, :text
  end
end
