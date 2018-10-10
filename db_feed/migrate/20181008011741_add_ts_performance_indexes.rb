class AddTsPerformanceIndexes < FeedMigrationBase[5.2]
  def change
    add_index :staging_constituents, :etfg_date
    add_index :staging_constituents, [:etfg_date, :datasource_id, :instrument_id], :name => 'staging_date_source_instrument'
  end
end
