class AddStagingIndices < FeedMigrationBase[5.2]
  def change
    add_index :staging_composites, :pooled_instrument_id
    add_index :staging_constituents, :instrument_id
  end
end
